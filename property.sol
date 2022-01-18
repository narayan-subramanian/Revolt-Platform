// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
contract RealEstate {
	// Declare state variables 

	uint256 pid;
	struct property{
      uint256 dimensions;          // Dimensions of the land , to-d0 - Should we convert it to string ?             
      uint256 area;                // Area in m^2
      uint256 marketValue;         // Market Value in Rupees
      bool status;            // Status - True - Available for sale
      string Name;          // Name of the property
      string location;          // Location of the property
      string pincode;               // Pincode/Zipcode of the location
      string typeOfLand;           // typeOfLand - 
      string category;              // Residential/commercial
      string description;       // About the property
   }

   property[] public properties; 

   uint256 public totalProperties; //Total of properties

   constructor() public{
      totalProperties=0;
   }

    event PropertyEvent(string propertyName , string pincode, uint256 marketValue);
   
    event MarketvalueUpdated(string propertyName , uint256 marketValue);

    event PropertyDelete(string propertyName);


    // Insert a new property into the blockchain
   function insert( string calldata properyName , string calldata location , string calldata pincode,string calldata typeOfLand,
                    string calldata category,string calldata description, uint256 dimensions,
                    uint256 area,uint256 marketValue) public returns (uint256 totalProperties){

        property memory newProperty = property(dimensions , area, marketValue,false, properyName, location, pincode, typeOfLand, category, description);
        properties.push(newProperty);
        totalProperties++;
        //emit event
        emit PropertyEvent (properyName, pincode, marketValue);
        return totalProperties;
   }

    // Update the market value of a existinig property
    function updateMarketvalue(string calldata propertyName, uint256  newmarketValue) public returns (bool success){
       //This has a problem we need loop
       for(uint256 i =0; i< totalProperties; i++){
           if(compareStrings(properties[i].Name ,propertyName)){
              properties[i].marketValue = newmarketValue;
              emit MarketvalueUpdated(propertyName, newmarketValue);
              return true;
           }
       }
       return false;
   }
   
   // Delete a property given the property name 
   function deleteproperty(string calldata propertyName) public returns(bool success){
        require(totalProperties > 0);
        for(uint256 i =0; i< totalProperties; i++){
           if(compareStrings(properties[i].Name , propertyName)){
              properties[i] = properties[totalProperties-1]; // pushing last into current arrray index which we gonna delete
              delete properties[totalProperties-1]; // now deleteing last index
              totalProperties--; //total count decrease
              properties.length--; // array length decrease
              //emit event
              emit PropertyDelete(propertyName);
              return true;
           }
       }
       return false;
   }
   
    // Get name,pincode and marletvalue the property details given name  - Can add more attributes to return as per requirement
   function getproperty(string calldata propertyName) public view 
            returns(string calldata name , string calldata pincode , uint256 marketValue){
        for(uint256 i =0; i< totalProperties; i++){
           if(compareStrings(properties[i].Name, propertyName)){
              //emit event
              return (properties[i].Name , properties[i].pincode , properties[i].marketValue);
           }
       }
       revert('property not found');
   }     
   
    // Compare string function
    function compareStrings(string memory a, string memory b) public view returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
   
   // Functions returns total number of properties
   function gettotalProperties() public view returns (uint256 length){
      return properties.length;
   }



}