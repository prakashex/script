#! /bin/bash

cd ~

npm create vite@latest ${1} -- --template react


cd ~/${1}


npm install

# tailwind

npm install -D tailwindcss postcss autoprefixer
npm install react-router-dom
npx tailwindcss init -p

cd ~/${1}/src/assets/
rm react.svg
cd ..
rm App.css


sed '17,69d' index.css | tee > indextemp
rm index.css
mv indextemp index.css


STR="*{\nmargin: 0;\npadding: 0;\nbox-sizing: border-box;\n}\n"
TAILWIND="@tailwind base;\n@tailwind components;\n@tailwind utilities;\n"

echo -e $TAILWIND | cat - index.css > tailwindtemp && mv tailwindtemp index.css

echo -e $STR > App.css


sed '10,29d' App.jsx | tee > temp
sed '2d;6d;9d' temp | tee > temptwo

sed -i '7i <div className="border-2 border-black text-center px-8 text-2xl">' temptwo
sed -i '8i  Hi , there <br /> This React boiler plate code , with tailwind has been generated using a script  <br /> to change the contents of this file go to App.jsx inside src folder <br /> <br /> -- Prakash' temptwo

rm temp App.jsx 

mv temptwo App.jsx




cd ..



## configure tailwind.config.cjs


sed '3d' tailwind.config.cjs | tee > tctemp
rm tailwind.config.cjs
sed -i '3i content: [ "./index.html",  "./src/**/*.{js,ts,jsx,tsx}",],' tctemp
mv tctemp tailwind.config.cjs


#initializing git repo

git init


code .








