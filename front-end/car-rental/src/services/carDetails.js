import axios from "axios";

const CAR_REST_API_URL = "http://localhost:8100/rv/getAll"

class carDetails
{
    //id=>{review}

    getCarDetails()
    {
        //axios.get(CAR_REST_API_URL)
        axios.get(CAR_REST_API_URL).catch(function (error) {
            if (error.response) {
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
            }
  });

    }
}

export default new carDetails()