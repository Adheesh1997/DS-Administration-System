import React, {Component} from "react"
import { Card, Button } from 'react-bootstrap';



class card extends Component{

    constructor(props){
        super(props);
        console.log(props.oneVehicle)
        this.state={
            
        }

    }

    render(){


        return(
            <>
                <Card
                  style={{ width: '80%',margin:"10%" }}
                  className="mb-2"
                >
                  <Card.Header>{this.props.oneVehicle.id}</Card.Header>
                  <Card.Body>
                    <Card.Title> 0 </Card.Title>
                    <Card.Text>
                      Some quick example text to build on the card title and make up the bulk
                      of the card's content.
                    </Card.Text>
                  </Card.Body>
                </Card>
            </>
        )
    }
}

export default card