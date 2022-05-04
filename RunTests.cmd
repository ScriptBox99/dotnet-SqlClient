@echo off

:: .NET CORE + .NET STANDARD LIBRARY TEST CASES
echo Building .NET Core Tests
call :pauseOnError msbuild -t:Clean

:: ************** IMPORTANT NOTE BEFORE PROCEEDING WITH "PACKAGE" AND "NETSTANDARDPACKAGE" REFERENCE TYPES ***************
:: CREATE A NUGET PACKAGE WITH BELOW COMMAND AND ADD TO LOCAL FOLDER + UPDATE NUGET CONFIG FILE TO READ FROM THAT LOCATION
:: msbuild -p:configuration=Release

:: REFERENCE TYPE "PACKAGE"
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetFx -p:ReferenceType=Package
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetCore -p:ReferenceType=Package
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetSt -p:ReferenceType=Package

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore5.0-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net5.0-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:Platform=x64 -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:Platform=x64 -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore5.0-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore5.0-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:Platform=Win32 -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore3.1-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=Package -p:Platform=Win32 -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore5.0-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-netcore5.0-manual-win32.xml

:: REFERENCE TYPE "NETSTANDARDPACKAGE"
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:TargetNetFxVersion=net462
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:Platform=x64 -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:Platform=x64 -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:Platform=x64 -p:TargetNetFxVersion=net462
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:Platform=x64 -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="x64" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="x64" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:Platform=Win32 -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore3.1-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandardPackage -p:Platform=Win32 -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-netcore5.0-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:Platform=Win32 -p:TargetNetFxVersion=net462
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetFxVersion=net462 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net462-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=NetStandardPackage -p:Platform=Win32 -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:Platform="Win32" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:Platform="Win32" -p:TargetNetFxVersion=net48 -p:ReferenceType=NetStandardPackage -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandardpackage-net48-manual-win32.xml

:: REFERENCE TYPE "NETSTANDARD" (We only build and test AnyCPU with Project Reference)
:: NUGET PACKAGE GENERATION IS NOT SUPPORTED FOR REFERNCE TYPE 'NETSTANDARD'
call :pauseOnError msbuild -p:Configuration="Release" -p:ReferenceType=NetStandard -p:GenerateNuget=false
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandard -p:TargetNetCoreVersion=netcoreapp3.1
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandard -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandard-netcore3.1-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=NetStandard -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandard-netcore3.1-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:ReferenceType=NetStandard -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandard -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandard-netcore5.0-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=NetStandard -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\netstandard-netcore5.0-manual-anycpu.xml

:: TESTING 'NETSTANDARD' REFERENCE TYPE WITH .NET FRAMEWORK 4.6.2+ AS TARGET FRAMEWORK IS INVALID CASE AS PROJECT REFERENCE DOES NOT LOAD SNI.DLL IN .NET FRAMEWORK RUNTIME.
:: CASE IS VERIFIED WITH RUNTIME.NATIVE.SYSTEM.DATA.SQLCLIENT.SNI AS WELL. TO TEST .NET FRAMEWORK TARGETS, USE 'NETSTANDARDPACKAGE' REFERENCE TYPE ONLY.

:: REFERENCE TYPE "PROJECT" (We only build and test AnyCPU with Project Reference)
call :pauseOnError msbuild -p:Configuration="Release"
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetFx
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetCoreAllOS
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetStAllOS
call :pauseOnError msbuild -p:Configuration="Release" -t:GenerateAKVProviderNugetPackage
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Project -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-netcore3.1-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=netcoreapp3.1 -p:ReferenceType=Project -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-netcore3.1-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetCore -p:TargetNetCoreVersion=net5.0
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests" -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Project -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-netcore5.0-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Configuration="Release" -p:TestTargetOS="Windowsnetcoreapp" --no-build -v n --filter "category!=nonnetcoreapptests&category!=failing&category!=nonwindowstests"  -p:Platform="AnyCPU" -p:TargetNetCoreVersion=net5.0 -p:ReferenceType=Project -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-netcore5.0-manual-anycpu.xml

:: .NET FRAMEWORK REFERENCE TYPE "PROJECT"
echo Building .NET Framework Tests
call :pauseOnError msbuild -p:Configuration="Release"
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetFx
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetCoreAllOS
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildAKVNetStAllOS
call :pauseOnError msbuild -p:Configuration="Release" -t:GenerateAKVProviderNugetPackage
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=x64
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=x64 -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=Win32
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net462-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=Win32 -p:TargetNetFxVersion=net48
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-functional-Win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\project-net48-manual-Win32.xml

:: .NET FRAMEWORK  REFERENCE TYPE "PACKAGE"
call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests"  -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:TargetNetFxVersion=net48 -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-functional-anycpu.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="AnyCPU" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-manual-anycpu.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=x64 -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=x64 -p:TargetNetFxVersion=net48 -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-functional-x64.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="x64" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-manual-x64.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=Win32 -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-functional-win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net462-manual-win32.xml

call :pauseOnError msbuild -p:Configuration="Release" -t:BuildTestsNetFx -p:Platform=Win32 -p:TargetNetFxVersion=net48 -p:ReferenceType=Package
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\FunctionalTests\Microsoft.Data.SqlClient.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-functional-Win32.xml
call :pauseOnError dotnet test "src\Microsoft.Data.SqlClient\tests\ManualTests\Microsoft.Data.SqlClient.ManualTesting.Tests.csproj" -p:Platform="Win32" -p:Configuration="Release" -p:TestTargetOS="Windowsnetfx" -p:TargetNetFxVersion=net48 --no-build -v n --filter "category!=nonnetfxtests&category!=failing&category!=nonwindowstests" -p:ReferenceType=Package -l:trx;LogFileName=..\..\..\..\..\artifacts\Results\package-net48-manual-Win32.xml

goto :eof

:pauseOnError
%*
if ERRORLEVEL 1 pause
goto :eof
