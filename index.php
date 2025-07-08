<?php
session_start();
if (isset($_SESSION['username']) && isset($_SESSION['role'])) {
    header("Location: public/overview/overview.php");
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    require_once __DIR__ . '/backend/dbh.inc.php';
    $username = trim($_POST['username'] ?? '');
    $password = trim($_POST['password'] ?? '');

    $stmt = $pdo->prepare("SELECT * FROM logininfo WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && $password === $user['password']) { // Use password_verify() if hashed
        $_SESSION['username'] = $user['username'];
        $_SESSION['role'] = $user['role'];
        header("Location: public/overview/overview.php");
        exit;
    } else {
        $error = "Invalid username or password.";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Olag Pequiño - Login</title>
    <link rel="icon" href="backend/logotab.png" type="image/jpeg">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --primary-dark-green: #1E4F39;
            --secondary-green: #2F7C56;
            --light-green: #4CAF50;
            --text-light: #F3F4F6;
            --text-dark: #374151;
        }
        .bg-primary-dark-green { background-color: var(--primary-dark-green); }
        .bg-secondary-green { background-color: var(--secondary-green); }
        .text-text-light { color: var(--text-light); }
        .text-text-dark { color: var(--text-dark); }
        body {
            background: linear-gradient(135deg, #f3f4f6 0%, #e0e7e9 100%);
            min-height: 100vh;
            min-width: 100vw;
            overflow: auto;
        }
        @keyframes fadeInScale {
            from { opacity: 0; transform: scale(0.9);}
            to { opacity: 1; transform: scale(1);}
        }
        .animate-fadeInScale {
            animation: fadeInScale 0.7s ease-out forwards;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans antialiased flex items-center justify-center min-h-screen min-w-full p-2">

    <div class="bg-white p-6 sm:p-10 rounded-2xl shadow-2xl text-center w-full max-w-md mx-auto animate-fadeInScale">
        <img src="backend/logo.jpg" alt="Barangay Logo" class="mx-auto mb-6 h-32 w-32 sm:h-40 sm:w-40 rounded-full object-cover shadow-lg border-4 border-primary-dark-green">

        <h1 class="text-2xl sm:text-3xl font-extrabold text-primary-dark-green mb-1 leading-tight">
            Barangay Olag Pequiño
        </h1>
        <p class="text-lg text-text-dark mb-6">Profiling System Login</p>

        <form id="loginForm" class="space-y-4 text-left" method="POST">
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                <input type="text" id="username" name="username" required autocomplete="username"
                    class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-secondary-green focus:border-secondary-green text-base">
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" id="password" name="password" required autocomplete="current-password"
                    class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:ring-secondary-green focus:border-secondary-green text-base">
            </div>
            <button type="submit" class="w-full bg-secondary-green text-text-light py-3 rounded-xl shadow-lg hover:bg-opacity-90 transition-all duration-300 text-lg font-semibold focus:outline-none focus:ring-4 focus:ring-secondary-green focus:ring-opacity-50">
                Login
            </button>
            <?php if ($error): ?>
                <p class="text-red-600 text-center mt-2"><?= htmlspecialchars($error) ?></p>
            <?php endif; ?>
        </form>
    </div>
</body>
</html>
