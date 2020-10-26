import Dependencies._

ThisBuild / scalaVersion     := "2.12.8"
ThisBuild / version          := "0.1.0-SNAPSHOT"

enablePlugins(ScalaJSPlugin)
scalaJSUseMainModuleInitializer := true

lazy val root = (project in file("."))
  .settings(
    name := "prime-to-js"
  )
