// android/build.gradle.kts

buildscript {
    dependencies {
        // ✅ Plugin de Android y Firebase (Google Services)
        classpath("com.android.tools.build:gradle:8.2.2") // Usa tu versión aquí si es distinta
        classpath("com.google.gms:google-services:4.3.15") // 🔥 SDK de Firebase
    }

    repositories {
        google()
        mavenCentral()
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ⚙️ Esto es propio del manejo de rutas de compilación que Flutter incluye
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
