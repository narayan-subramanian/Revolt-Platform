//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <=0.9.0;

contract reciever
{
    address payable public reciever; 
}


contract sell
{
    address public owner;

    constructor()
    {
        owner = msg.sender;
    }
    struct land
    {
        address owneraddress;
        string location;
        uint cost;
        uint LandId;
        uint sellStatus;

    }
    uint totalLandCount =0;

    //land addition
    function addLand(address propertyOwner,string _location,uint _cost) public isOwner
    {
        totalLandCount = totalLandCount + 1;
        Land memory myLand = Land(
            {
            owneraddress: propertyOwner,
            location: _location,
            cost: _cost,
            LandId: totalLandCount,
            sellStatus: 1
            });

            _ownedLands[msg.sender].push(myLand);


    }
    // land updation


    function transferLand(address _landBuyer, uint _landID) payable public returns(bool)
    {
        for(uint i=0; i < (__ownedLands[msg.sender].length);i++)    
        {
            //if given land ID is indeed in owner's collection
            if (__ownedLands[msg.sender][i].landID == _landID)
            {
                
                    msg.sender.transfer(__ownedLands[msg.sender][i].cost);
                    transferEther(landBuyer,_ownedLands[msg.sender][i].cost);
                    UpdateStatus("Sold",__ownedLands[msg.sender][i].cost);
                    balance[msg.sender]+=__ownedLands[msg.sender][i].cost;
                   
    }
        }}
    
}