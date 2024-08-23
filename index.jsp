<!DOCTYPE html>

<html>

<head>
    <title>Mental Health Care</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 80%;
            max-width: 800px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 2px solid #c3cfe2;
            position: relative;
            overflow: hidden;
        }

        .page {
            display: none;
            animation: fadeIn 0.5s ease-in-out;
        }

        .page.active {
            display: block;
        }

        .question-page {
            padding: 20px;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1,
        h2 {
            text-align: center;
            color: #708dcb;
            font-weight: bold;
        }

        p {
            text-align: center;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        .question h2 {
            font-family: 'Comic Sans MS', cursive;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        label {
            display: block;
            margin: 10px 0;
            font-size: 1rem;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        label:hover {
            color: #7694d3;
        }

        button {
            background-color: #7999df;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 1rem;
            margin: 10px 5px;
            display: inline-flex;
            align-items: center;
        }

        button i {
            margin-left: 8px;
        }

        button:hover {
            background-color: #86abf4;
            transform: scale(1.05);
        }

        .nav-btn {
            margin-right: 10px;
        }

        .submit-btn {
            background-color: #5ccd60;
        }

        .submit-btn:hover {
            background-color: #5ed264;
        }

        .loading-bar {
            width: 100%;
            height: 20px;
            background-color: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin: 20px 0;
        }

        .loading-bar .progress {
            width: 0;
            height: 100%;
            background-color: #6d8bcd;
            animation: loading 3s linear forwards;
        }

        .charts {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }

        #personality-type {
            text-align: center;
            margin: 20px 0;
            font-size: 1.2rem;
            font-weight: bold;
        }

        .see-personality-btn,
        .restart-btn {
            background-color: #ec5b2f;
        }

        .see-personality-btn:hover,
        .restart-btn:hover {
            background-color: #e64a19;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes loading {
            from {
                width: 0;
            }

            to {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <script>
        let currentPage = 1;

        function nextPage() {
            showPage(currentPage + 1);
        }

        function prevPage() {
            showPage(currentPage - 1);
        }

        function showPage(pageIdentifier) {
            const pages = document.querySelectorAll('.page');
            pages.forEach(page => page.classList.remove('active'));

            const targetPage = document.getElementById(`page-${pageIdentifier}`);
            if (targetPage) {
                targetPage.classList.add('active');
            } else {
                console.error(`Page with id 'page-${pageIdentifier}' not found.`);
            }

            currentPage = pageIdentifier;
        }

        function submitQuiz() {
            const questions = document.querySelectorAll('.question');
            questions.forEach((question, index) => {
                const answer = document.querySelector(`input[name="q${index + 1}"]:checked`);
                if (answer) {
                    updateResults(answer.value, index + 1);
                }
            });
            showLoadingPage();
        }

        function showLoadingPage() {
            showPage('loading');
            setTimeout(showResultsPage, 2000);
        }

        function showResultsPage() {
            showPage('results');
            drawPieChart();
        }

        function updateResults(value, questionNumber) {
            // Result calculation logic (you can implement your own logic here)
        }

        function drawPieChart() {
            const ctx = document.getElementById('result-pie-chart').getContext('2d');
            const data = {
                labels: ['Anger', 'Calmness', 'Acceptance', 'Control', 'Anxiety', 'Patience'],
                datasets: [{
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'],
                }]
            };
            new Chart(ctx, {
                type: 'pie',
                data: data,
            });
        }

        function seePersonality() {
            const personalityTypes = [
                'Creative Thinker', 'Natural Leader', 'Empathetic Listener',
                'Logical Analyst', 'Energetic Motivator', 'Calm Mediator'
            ];
            const randomPersonality = personalityTypes[Math.floor(Math.random() * personalityTypes.length)];
            document.getElementById('personality-type').innerText = `Your personality is: ${randomPersonality}`;
        }

        function restartQuiz() {
            document.querySelectorAll('input[type="radio"]').forEach(input => input.checked = false);
            showPage(1);
            document.getElementById('personality-type').innerText = 'Click the button to see your personality type.';
        }

    </script>
    <div class="container">
        <!-- Quiz Pages -->
        <div id="page-1" class="page question-page active">
            <h1>? Mental Health Check-In</h1>
            <p>Answer the questions honestly to get a better insight into your mental health.</p>
            <div class="question">
                <h2>1. How often do you feel overwhelmed with emotions?</h2>
                <label><input type="radio" name="q1" value="high"> Very often</label>
                <label><input type="radio" name="q1" value="medium"> Sometimes</label>
                <label><input type="radio" name="q1" value="low"> Rarely</label>
            </div>
            <div class="question">
                <h2>2. How well do you handle stress in your daily life?</h2>
                <label><input type="radio" name="q2" value="low"> Very well</label>
                <label><input type="radio" name="q2" value="medium"> Moderately well</label>
                <label><input type="radio" name="q2" value="high"> Poorly</label>
            </div>
            <button class="nav-btn" onclick="nextPage()">Next <i class="fas fa-arrow-right"></i></button>
        </div>

        <div id="page-2" class="page question-page">
            <h1>? Mental Health Check-In</h1>
            <div class="question">
                <h2>3. How often do you feel anxious?</h2>
                <label><input type="radio" name="q3" value="high"> Frequently</label>
                <label><input type="radio" name="q3" value="medium"> Occasionally</label>
                <label><input type="radio" name="q3" value="low"> Rarely</label>
            </div>
            <div class="question">
                <h2>4. How easily do you get frustrated?</h2>
                <label><input type="radio" name="q4" value="high"> Very easily</label>
                <label><input type="radio" name="q4" value="medium"> Sometimes</label>
                <label><input type="radio" name="q4" value="low"> Hardly ever</label>
            </div>
            <div class="question">
                <h2>5. How do you usually respond to unexpected challenges?</h2>
                <label><input type="radio" name="q5" value="high"> With panic</label>
                <label><input type="radio" name="q5" value="medium"> With concern</label>
                <label><input type="radio" name="q5" value="low"> With calmness</label>
            </div>
            <button class="nav-btn" onclick="prevPage()"><i class="fas fa-arrow-left"></i> Previous</button>
            <button class="submit-btn" onclick="submitQuiz()">Submit <i class="fas fa-check"></i></button>
        </div>

        <!-- Loading Page -->
        <div id="loading-page" class="page">
            <h2>Processing Your Results...</h2>
            <div class="loading-bar">
                <div class="progress"></div>
            </div>
        </div>

        <!-- Results Page -->
        <div id="results-page" class="page">
            <h2>Your Mental Health Profile</h2>
            <div class="charts">
                <canvas id="result-pie-chart" width="400" height="400"></canvas>
            </div>
            <div id="personality-type" class="personality-type"></div>
            <button class="see-personality-btn" onclick="seePersonality()">See Your Personality Tag <i
                    class="fas fa-user"></i></button>
        </div>

        <!-- Personality Page -->
        <div id="personality-page" class="page">
            <h2>Your Personality Type</h2>
            <div id="personality-type"></div>
            <button class="restart-btn" onclick="restartQuiz()">Restart Quiz <i class="fas fa-redo"></i></button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="script.js"></script>
</body>

</html>
</body>

</html>