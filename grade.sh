CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"
rm ListExamples.java
rm *.class
rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo "ListExamples.java found"
else
    echo "ListExamples.java not found"
    exit 1
fi

FILTER=`grep -c -i "static List<String> filter(List<String> list, StringChecker sc)" ListExamples.java`
MERGE=`grep -c -i "static List<String> merge(List<String> list1, List<String> list2)" ListExamples.java`
if [[ $FILTER -ne 0 ]]
then
    echo "filter method found"
else
    echo "filter method not found"
    exit 1
fi

if [[ $MERGE -ne 0 ]]
then
    echo "merge method found"
else
    echo "merge method not found"
    exit 1
fi

cp ListExamples.java ..
cd ..
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore > errorFile.txt 2>&1
if [[ $? -eq 0 ]]
then
    echo "Implementation Passes"
else
    echo "Implementation Error"
    cat errorFile.txt
fi

echo "Finished"



