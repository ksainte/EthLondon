// import Image from "next/image";
import Navbar from "./components/Navbar";
import Header from "./components/Header";
import "./page.css";


export default function Home() {
  return (
    <main style={{width:'100vw'}}>
          <Navbar/>
     <div className='App_body'>
     <Header/>      </div>
    </main>
  );
}

