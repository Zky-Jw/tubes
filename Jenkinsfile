pipeline {
    agent any
    environment {
        // Variabel lingkungan untuk koneksi MySQL
        MYSQL_HOST = 'app'
        MYSQL_USER = 'root'
        MYSQL_PASSWORD = 'root'
        MYSQL_DB = 'laraveldocker'
    }
    stages {
        stage('Checkout dari Git') {
            steps {
                git branch: 'Rizky', url: 'https://github.com/Zky-Jw/tubes.git'
            }
        }
        stage('Ambil Image dari Dockerhub') {
            steps {
                echo 'Berhasil mengambil image...'
            }
        }
        stage('Jalankan MySQL') {
            steps {
                script {
                    // Ambil image MySQL
                    def mysql = docker.image('rizky222/mysql')
                    mysql.pull()

                    // Jalankan container MySQL
                    def mysqlContainer = mysql.run('-e MYSQL_ROOT_PASSWORD=laraveldocker -e MYSQL_DATABASE=inventorygudang -e MYSQL_USER=root -e MYSQL_PASSWORD=root --name mysql_db')
                    echo 'Container MySQL sedang berjalan...'

                    // Tunggu MySQL siap
                    echo 'Menunggu MySQL siap...'
                    sleep(20) // Tunggu 20 detik agar MySQL bisa mulai
                }
            }
        }
        stage('Jalankan phpMyAdmin') {
            steps {
                script {
                    // Ambil image phpMyAdmin
                    def phpMyAdmin = docker.image('rizky222/phpmyadmin')
                    phpMyAdmin.pull()

                    // Jalankan container phpMyAdmin dan hubungkan dengan MySQL
                    def phpMyAdminContainer = phpMyAdmin.run("-e PMA_HOST=${MYSQL_HOST} -e PMA_USER=${MYSQL_USER} -e PMA_PASSWORD=${MYSQL_PASSWORD} -p 9001:80 --name phpmyadmin")
                    echo 'Container phpMyAdmin sedang berjalan...'
                }
            }
        }
        stage('Jalankan File PHP') {
            steps {
                script {
                    // Ambil image environment Laravel Docker
                    def phpEnv = docker.image('rizky222/laraveldocker')
                    phpEnv.pull()

                    // Jalankan container Laravel Docker dan hubungkan dengan MySQL
                    def phpContainer = phpEnv.run("-e MYSQL_HOST=${MYSQL_HOST} -e MYSQL_USER=${MYSQL_USER} -e MYSQL_PASSWORD=${MYSQL_PASSWORD} -e MYSQL_DB=${MYSQL_DB} -p 9000:80 --name laravel_app")
                    echo 'Container environment Laravel Docker sedang berjalan...'
                }
            }
        }
    }
}
