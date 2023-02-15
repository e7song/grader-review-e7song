CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm ListExamples*
rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[-f ListExamples.java]]
then
    echo "ListExamples.java found"
else
    echo "ListExamples.java not found"
    exit 1
fi

cp ListExamples.java ..
cd..
javac -cp CPATH *.java
java CPATH org.junit.runner.JUnitCore TestListExamples > errorFile.txt 2>&1
if ($? -eq 0)
then
    echo "Implementation Passes"
else
    echo "Implementation Error"
    cat errorFile.txt
fi

echo "Finished"



