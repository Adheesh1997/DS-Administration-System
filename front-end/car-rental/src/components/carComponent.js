import React from 'react'
import carDetails from '../services/carDetails'


class carComponent extends React.Component
{

    constructor()
    {
        this.state = {
            cars:[]
        }
    }

    componentDidMount(){
        carDetails.getCarDetails().then((response) => {
            this.setState({
                cars : response.data    
            })
        })
    }

    render(){
        return(
            <div>

            </div>
        )
    }

}


export default carComponent