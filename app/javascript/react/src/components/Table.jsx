import * as React from 'react'                          
import * as ReactDOM from 'react-dom'                   
                                                        
const Table = (props) => {
  return (
    <table className="table mt-6">
        <thead>
        <tr>
            <th>Full Name</th>
            <th>Email</th>
            <th>Vehicle Type</th>
            <th>Vehicle Name</th>
            <th>Vehicle Length</th>
        </tr>
        </thead>
        <tbody>
        {props.results.map((row, i) => (  
        <tr key={i}>
            <td>{row.firstName} {row.lastName}</td>
            <td>{row.email}</td>
            <td>{row.vehicleType}</td>
            <td>{row.vehicleName}</td>
            <td>{row.vehicleLength}</td>
        </tr>
        ))}
        </tbody>
    </table>
  )
}

export default Table