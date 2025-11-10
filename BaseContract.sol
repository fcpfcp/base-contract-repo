## files
address public owner;
bool public paused;


// Simple Reentrancy guard
uint256 private _status;
uint256 private constant _NOT_ENTERED = 1;
uint256 private constant _ENTERED = 2;


event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
event Paused(address account);
event Unpaused(address account);


modifier onlyOwner() {
require(msg.sender == owner, "BaseContract: caller is not the owner");
_;
}


modifier whenNotPaused() {
require(!paused, "BaseContract: paused");
_;
}


modifier whenPaused() {
require(paused, "BaseContract: not paused");
_;
}


modifier nonReentrant() {
require(_status != _ENTERED, "BaseContract: reentrant call");
_status = _ENTERED;
_;
_status = _NOT_ENTERED;
}


constructor() {
owner = msg.sender;
paused = false;
_status = _NOT_ENTERED;
emit OwnershipTransferred(address(0), owner);
}


/** @dev Transfers ownership to a new address. Can only be called by the current owner. */
function transferOwnership(address newOwner) external onlyOwner {
require(newOwner != address(0), "BaseContract: new owner is the zero address");
emit OwnershipTransferred(owner, newOwner);
owner = newOwner;
}


/** @dev Pause contract. Prevents functions guarded by whenNotPaused from running. */
function pause() external onlyOwner whenNotPaused {
paused = true;
emit Paused(msg.sender);
}


/** @dev Unpause contract. */
function unpause() external onlyOwner whenPaused {
paused = false;
emit Unpaused(msg.sender);
}


/**
* @dev Example protected action showing how to use whenNotPaused and nonReentrant.
* Replace or extend this with your project logic.
*/
uint256 public counter;


function protectedIncrement() external whenNotPaused nonReentrant {
// your protected logic here
counter += 1;
}


// Add additional helper functions and modifiers as needed for your project.
}
```
