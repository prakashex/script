#! /bin/bash

dir=$(pwd)

npm create vite@latest ${1} -- --template react


cd ${dir}/${1}


npm install

# tailwind

npm install -D tailwindcss postcss autoprefixer
npm install react-router-dom
npx tailwindcss init -p

cd ${dir}/${1}/src/assets/
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

mkdir Common\ Components
mkdir Pages
cd Pages

echo "import React, { useContext } from 'react'
import { Context } from '../Context/Context'


function Home() {
    const {testState} = useContext(Context)
  return (
    <div>Home
        This variable is coming from Context -- {testState}
    </div>

  )
}

export default Home" > Home.jsx

cd ..

mkdir Context
cd Context
echo "import React , {createContext, useState} from '"react"'


const Context = createContext()

const {Provider} = Context


function ContextProvider(props) {
    const [testState , setTestState] = useState('test variable')


    const {children} = props

  return (
    <Provider


        value={{
            testState
        }}>

        {children}

    </Provider>
  )
}

export {Context , ContextProvider}" > Context.jsx

cd ..

mkdir Config

cd Config
touch Config.jsx

cd ..

echo "import React from 'react'
import ReactDOM from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import App from './App'
import { ContextProvider } from './Context/Context'
import './index.css'
import Home from './Pages/Home'



const router = createBrowserRouter([
  {
    path: '/',
    element: <App />
  },
  {
    path: '/home',
    element: <Home />
  }
])



ReactDOM.createRoot(document.getElementById('root')).render(

  <React.StrictMode>
    <ContextProvider>
    <RouterProvider router={router} />
    </ContextProvider>
  </React.StrictMode>,
)
" > main.jsx

cd ..



## configure tailwind.config.cjs


sed '3d' tailwind.config.cjs | tee > tctemp
rm tailwind.config.cjs
sed -i '3i content: [ "./index.html",  "./src/**/*.{js,ts,jsx,tsx}",],' tctemp
mv tctemp tailwind.config.cjs


tempDir=$(pwd)

#initializing git repo

if [ "$tempDir" == "${dir}/${1}" ]; then
	git init
	code .
else
	echo "something went wrong"
fi












