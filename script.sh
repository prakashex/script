#! /bin/bash

dir=$(pwd)

npm create vite@latest ${1} -- --template react


cd ${dir}/${1}


npm install

# tailwind

npm install -D tailwindcss postcss autoprefixer
npm install react-router-dom axios
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
sed -i '8i  Hi , there <br /> This React boiler plate code , with browser router and Context preconfigured along with tailwind , this has been generated using a script  <br /> to change the contents of this page go to App.jsx inside src folder <br /> <br /> ' temptwo

rm temp App.jsx

mv temptwo App.jsx

mkdir components
cd components 

echo "import React from 'react'
import { API_END_POINTS, data, headers } from '../config/Config'
import { useCheckSub } from '../hooks/useCheckSub';
import {useConfig } from '../hooks/useConfig'



function Protected() {


   const {responseData, loading , error} = useConfig(API_END_POINTS.config , data , headers);
   const {subData } = useCheckSub(API_END_POINTS.checkSub, {'msisdn': '701701701' }, headers)




  return (
    <div>Protected</div>
  )
}

export default Protected" >> Protected.jsx

cd ..

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



mkdir config
cd Config
echo "export const API_BASE_URL='http://www.ticket2umrah.com/api/'
export const API_END_POINTS={
    config:API_BASE_URL+'appConfig',
    checkSub:API_BASE_URL+'checkSubscription'
}


export const data = {
    calling_code :  93,
    mcc: 'web',
    mnc: 'web',
  };

export const headers =  {
    'Username': 'web',
    'Accept': 'application/json, */*',
    'Reqfrom': 'web',
    'Buildtype': '',
    'Cache-Control': 'no-cache',
    'Language': 'en',
    'Servicefor': 'awccAFG'
  }
"> Config.jsx

cd ..


mkdir hooks
cd hooks 

echo "import axios from 'axios';
import { useEffect, useState } from 'react';

export function useConfig(url , apiData ={} , headers={}){
    const [configData , setConfigData] = useState();
    const [error , setError] = useState();
    const [loading , setLoading] = useState(false);
console.log('url --> ', url)
console.log('data --> ', apiData)
console.log('headers --> ', headers)

useEffect( () => {
    setLoading(true)
    axios({
        method: 'post',
        url: url,
        data: apiData,
        headers: headers
    }).then(resp => setConfigData(resp.data))
      .catch(error => setError(error))
      .finally(() => setLoading(false))
},[url])



return {configData , loading , error}

}
" >>  useConfig.jsx


echo "import axios from 'axios';
import { useEffect, useState } from 'react';

export function useCheckSub(url , apiData ={} , headers={}){
    const [subData , setSubData] = useState();
    const [subError , setSubError] = useState();
    const [subLoading , setSubLoading] = useState(false);
console.log('url --> ', url)
console.log('data --> ', apiData)
console.log('headers --> ', headers)

useEffect( () => {
    setSubLoading(true)
    axios({
        method: 'post',
        url: url,
        data: apiData,
        headers: headers
    }).then(resp => setSubData(resp.data))
      .catch(error => setSubError(error))
      .finally(() => setSubLoading(false))
},[url])



return {subData  , subLoading , subError}

}
" >> useCheckSub.jsx

cd ..


echo "import React from 'react'
import ReactDOM from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import App from './App'
import Protected from './components/Protected'
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
    element: <Protected Component={Home} />
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












