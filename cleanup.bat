@echo off
echo Cleaning up root directory...

:: Copy README.md to both project directories
echo Copying README.md to project directories...
copy README.md tmf-query-frontend\README.md
copy README.md trino-tmf-connector\README.md

:: Remove source directories that have been copied
rmdir /S /Q src
rmdir /S /Q node_modules
rmdir /S /Q .next

:: Remove configuration files that have been copied
del pom.xml
del package.json
del package-lock.json
del next.config.js
del postcss.config.js
del tailwind.config.js
del tsconfig.json
del next-env.d.ts

:: Remove temporary scripts
del copy_files.bat
del copy_frontend_files.bat

:: Remove other unnecessary files
del nodeapproach.js
del README.md

echo Cleanup complete! Only project directories and research files remain. 