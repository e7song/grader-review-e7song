rm -rf student-submission/
CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"
git clone $1 student-submission/
echo 'Finished cloning'

cd student-submission/

if [[ -f ListExamples.java ]]
then
    echo "ListExamples.java found"
else
    echo "ListExamples.java not found"
    cd ..
    rm -rf student-submission/
    javac Server.java
    javac GradeServer.java
    exit 1
fi

FILTER=`grep -c "static List<String> filter(List<String> list, StringChecker sc)" ListExamples.java`
MERGE=`grep -c "static List<String> merge(List<String> list1, List<String> list2)" ListExamples.java`
if [[ $FILTER -eq 1 ]]
then
    echo "Filter method found."
else
    rm ListExamples.java
    rm -rf student-submission/
    echo "Filter method not found."
    cd ..
    javac Server.java
    javac GradeServer.java
    exit 1
fi

if [[ $MERGE -eq 1 ]]
then
    echo "Merge method found."
else
    echo "Merge method not found."
    rm ListExamples.java
    rm -rf student-submission/
    cd ..
    javac Server.java
    javac GradeServer.java
    exit 1
fi

cp ListExamples.java ..
cd ..
javac -cp $CPATH *.java > compileError.txt 2>&1

if [[ $? -ne 0 ]]
then
    echo "Compile Error"
    cat compileError.txt
    rm ListExamples.java
    rm -rf student-submission/
    rm *.txt
    javac Server.java
    javac GradeServer.java
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore > errorFile.txt 2>&1
if [[ $? -eq 0 ]]
then
    echo "Implementation Passes"
else
    echo "Implementation Error"
    cat errorFile.txt
fi

SCORE=`grep -c "OK" errorFile.txt`
if [[ $SCORE -eq 1 ]]
then
    echo "100.00/100.00- Well Done!"
else
    echo "Errors- Need to Fix"
fi

rm ListExamples.java
rm *.class
rm -rf student-submission/
rm *.txt
javac Server.java
javac GradeServer.java

# rm -rf student-submission
# git clone $1 student-submission
# echo 'Finished cloning'

# cp student-submission/ListExamples.java ./
# javac -cp $CPATH *.java
# java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

