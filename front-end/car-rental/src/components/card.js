import React, {Component} from "react"
import { Card, Button } from 'react-bootstrap';



class card extends Component{

    constructor(props){
        super(props);

        this.state={
            
        }

    }

    render(){


        return(
            <>
                <Card
                  style={{ width: '50rem' }}
                  className="mb-2"
                >
                  <Card.Header>Header</Card.Header>
                  <Card.Body>
                    <Card.Title> Card Title </Card.Title>
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