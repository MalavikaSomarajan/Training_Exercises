const students = [];

function addStudent() {
    const name = document.getElementById('studentName').value;
    const grade = parseFloat(document.getElementById('studentGrade').value);
    const errorMessage = document.getElementById('error-message');

    if (!name) {
        errorMessage.textContent = 'Please enter a student name.';
        return;
    }

    if (isNaN(grade) || grade < 0 || grade > 100) {
        errorMessage.textContent = 'Please enter a valid grade between 0 and 100.';
        return;
    }

    errorMessage.textContent = '';

    students.push({ name, grade });

    document.getElementById('studentName').value = '';
    document.getElementById('studentGrade').value = '';
}
function displayGrades() {
    const studentList = document.getElementById('student-list');
    const gradesList = document.getElementById('grades-list');
    gradesList.innerHTML = '';

    if (students.length === 0) {
        studentList.style.display = 'none';
        return;
    }

    students.forEach(student => {
        const listItem = document.createElement('li');
        listItem.textContent = `${student.name}: ${student.grade}`;
        gradesList.appendChild(listItem);
    });

    studentList.style.display = 'block';
}

function calculateAverage() {
    const averageGradeDiv = document.getElementById('average-grade');

    if (students.length === 0) {
        averageGradeDiv.textContent = 'No students added yet.';
        return;
    }

    const totalGrades = students.reduce((sum, student) => sum + student.grade, 0);
    const average = totalGrades / students.length;

    averageGradeDiv.textContent = `Average Grade: ${average.toFixed(2)}`;
}
