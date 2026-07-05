@echo off
chcp 65001 > nul
echo ==============================================
echo  正在启动《刘文俊 个人简历》本地部署服务...
echo  地址：http://localhost:3000
echo ==============================================
start http://localhost:3000

REM 优先使用 python；若不存在则回退到 py -3（Windows Python Launcher）
where python >nul 2>nul
if %ERRORLEVEL%==0 (
  python -m http.server 3000
) else (
  where py >nul 2>nul
  if %ERRORLEVEL%==0 (
    py -3 -m http.server 3000
  ) else (
    echo.
    echo [错误] 未检测到 Python。请先安装 Python 3 后重试：
    echo   https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
  )
)
pause
