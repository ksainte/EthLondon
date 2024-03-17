import React from 'react'
import './Header.css';
import header from '../../assets/h1.jpg';
import art_header from "../assets/Header background for top of pages .jpg";

import Image from "next/image";

function Header() {
  return (
    <div className='Header' >

      <div className='Header_components'>
      <article className="see">
      <h2>Tired of managing your DeFi positions? </h2>
      <h3>With Chainlink's Upkeep, you can now get it all on Auto-Pilot!</h3>

      <h3 >Once funds deposited, EasyConnect handles two functions:</h3>

    
      </article>


      
      </div>


      <div className="oval-box">
        Withdraw
      </div>
      <div className="test">Withdraw triggered whenever liquity in the pool</div>
      <div className="test">WMATIC-USD decreases over extended periods of time.</div>
      <div className="test">Less liquidity implies more volatility and higher</div>
      <div className="test">exposure.</div>




      <div className="oval-box1">
        Repay
      </div>
      <div className="test1">Repay triggered whenever the utilization rate in</div>
      <div className="test1">the pool of the underlying is past 90%. Thus,</div>
      <div className="test1">allowing not to pay excessive interest.</div>



    </div>
  )
}

export default Header


