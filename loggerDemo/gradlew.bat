@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar

@rem Execute Gradle
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% "-Dorg.gradle.appname=%APP_BASE_NAME%" -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%GRADLE_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega


public class Main {
    public static void main(String[] args) {
        // Your string representation of key-value pairs
        String keyValueString = "{ key1=value1, key2=value2=is=here, key3=value3, key4=value4,with,comma }";

        // Convert to JSON-like object
        JsonNode jsonObject = convertToJson(keyValueString);

        // Key to check
        String keyToCheck = "key2";

        // Check if the key exists
        if (doesKeyExist(jsonObject, keyToCheck)) {
            System.out.println("Key exists: " + keyToCheck);
        } else {
            System.out.println("Key does not exist: " + keyToCheck);
        }
    }

    // Function to convert a string to a JSON-like object
    private static JsonNode convertToJson(String keyValueString) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();

        // Flag to indicate if the current character is inside a value
        boolean insideValue = false;

        // StringBuilder to construct the key-value pairs
        StringBuilder jsonString = new StringBuilder("{");

        // Variables to store the current key and value
        StringBuilder currentKey = new StringBuilder();
        StringBuilder currentValue = new StringBuilder();

        // Iterate through the characters in the input string
        for (char c : keyValueString.toCharArray()) {
            if (c == '=') {
                // If '=' is encountered, set the flag to indicate that the next characters belong to a value
                insideValue = true;
            } else if (c == ',' && !insideValue) {
                // If ',' is encountered and not inside a value, it marks the end of a key-value pair
                jsonString.append("\"").append(currentKey.toString().trim()).append("\":\"").append(currentValue.toString().trim()).append("\",");
                // Reset key and value for the next pair
                currentKey.setLength(0);
                currentValue.setLength(0);
                insideValue = false;
            } else {
                // Otherwise, append the character to the current key or value
                if (insideValue) {
                    currentValue.append(c);
                } else {
                    currentKey.append(c);
                }
            }
        }

        // Handle the last key-value pair after the loop ends
        jsonString.append("\"").append(currentKey.toString().trim()).append("\":\"").append(currentValue.toString().trim()).append("\"}");

        return objectMapper.readTree(jsonString.toString());
    }

    // Function to check if a key exists in the JSON-like object
    private static boolean doesKeyExist(JsonNode jsonObject, String keyToCheck) {
        return jsonObject.has(keyToCheck);
    }
}


