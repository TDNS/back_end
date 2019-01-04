
pragma solidity ^0.4.2;

contract TDNS {
  
  uint private feeToRegister ;
  address private owner ;
  uint256 private balance ;
  address private defaultAddress ;
  uint256 private counter ;
  
  
  constructor() public {
    
    owner = msg.sender ;
    feeToRegister = 0 ;
    balance = 0 ;
    
  }
  
  modifier onlyOwner()
  {
    
    require(msg.sender == owner);
    _;
    
  }
  
  struct walletAddress {
    
    address myAddress ;
    
  }
  
  mapping (string => walletAddress ) myWallet ;
  
  function add( string name ) public payable {
    
    require (getBalance() >= balance ) ;
    require(msg.value >= feeToRegister);
    require (getAddress(name) == getDefaultAddress() ) ;
    
    myWallet[name]= walletAddress({myAddress : msg.sender});
    counter++ ;
    
  }
  
  
  function getAddress (string name ) public view returns ( address )
  {
    walletAddress storage wa = myWallet[name] ;
    
    return wa.myAddress ;
    
  }
  
  function getDefaultAddress () private view returns (address)
  {
    
    return defaultAddress ;
    
  }
  
  function withdraw() onlyOwner public
  {
    owner.transfer(address(this).balance);
  }
  
  
  function updateFeeToRegister(uint _feeToRegister) onlyOwner public
  {
    feeToRegister = _feeToRegister;
  }
  
  
  function changeOwner(address _owner) onlyOwner public
  {
    owner = _owner;
  }
  
  function addWallet ( string name , address myaddress ) onlyOwner public payable {
    
    require(msg.value >= feeToRegister );
    
    require (getAddress(name) == getDefaultAddress() ) ;
    
    myWallet[name]= walletAddress({myAddress : myaddress});
    counter++ ;
    
    
  }
  
  function getSize () public view returns (uint256 )
  {
    
    return counter ;
    
  }
  
  function getBalance () public view returns (uint256 )
  {
    
    return (address(msg.sender).balance);
    
  }
  
  function updateBalance(uint256 _balance) onlyOwner public {
    
    balance = _balance ;
    
  }
  
  function() external payable {
    
  }
  
  
  function mySelfDestruct() public onlyOwner  () {
    
    selfdestruct(owner) ;
    
  }
  
  
}



