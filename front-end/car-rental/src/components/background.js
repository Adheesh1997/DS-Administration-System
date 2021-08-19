import React from 'react'
import './background.css'
import Card from './card.js'



class background extends React.Component{

    constructor(){
        super()
        
        this.state={
            vehicleList:[],
        }
    }

    render(){
        let styleParagraph={
            color:'black',
            fontSize:20,
        }

        const vehicle = this.state.vehicleList.map(vehicle => <Card service={service}/>)
        
        return(
            
            <div>
                <div className="card card-image"  >
                    <div className="jumbotron text-white text-center rgba-stylish-strong py-5 px-4" >
                        <div class="py-5"style={{backgroundColor:'rgba(160,160,160,0.7)',borderRadius:10} }>
                            <h2 className="card-title h2 my-4 py-2" style={{color:'rgb(32,32,32)'}}>Rent a vehicle from here.</h2>
                            <p className="mb-4 pb-2 px-md-5 mx-md-5" style={styleParagraph}>Check the reviews and choose best vehicle for you.</p>
                            {/* <MDBBtn rounded size="lg"  className="btn "gradient="aqua"><MDBIcon icon="plus" className="ml-2" onclick={this.makeAppointment} />   Make an appointment</MDBBtn> */}
                        </div>
                    </div>
                </div>
                <div className="centered"> 

                    <div>
                        <select class="form-select" aria-label="Default select example">
                            <option value="1" selected>All</option>
                            <option value="2">Cars</option>
                            <option value="3">Trucks</option>
                            <option value="4">Lorries</option>
                            <option value="5">Vans</option>
                        </select>
                    </div>

                    <div>
                        {vehicle}
                    </div>
                </div>
            </div>
        )
    }
}

export default background