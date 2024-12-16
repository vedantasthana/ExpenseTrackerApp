import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';



const Header: React.FC = () => {
  const { isAuthenticated, logout } = useAuth();

  const logoutClick = () => {
    logout();
  }
  return (
    <>
    <header className="bg-green-400 text-white p-4 shadow-md">
      <div className="container flex justify-between items-center" style={{marginLeft:'10px', maxWidth:'97.3vw'}}>
        <h1 className="text-2xl font-bold">
          <Link to={!isAuthenticated ? "/login" : "/home"} className='text-gray-700'>Expense Tracker</Link>
        </h1>
        <nav className="space-x-4">
          {isAuthenticated ? (
            <>
              <Link to="/home" className="hover:underline text-gray-700">Dashboard</Link>
              <Link to="/profile" className="hover:underline text-gray-700">Profile</Link>
              <Link to="/expenses" className="hover:underline text-gray-700">Expenses</Link>
              <button onClick={logoutClick} className="hover:underline text-gray-700">Logout</button>
            </>
          ) : (
              <>
              <Link to={`/login`} className="hover:underline text-gray-700">Login</Link>
              <Link to="/register" className="hover:underline text-gray-700">Register</Link>
              </>
          )}
        </nav>
      </div>
    </header>
    </>
  );
};

export default Header;
