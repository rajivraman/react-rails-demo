import * as React from 'react'                          
import * as ReactDOM from 'react-dom'
import Table from './Table'
                                                        
const Upload = () => {
    const [results, setResults] = React.useState(null);
    const [submitting, setSubmitting] = React.useState(false);
    const [error, setError] = React.useState(null);

  const handleSubmit = async (event) => {
    event.preventDefault();

    setSubmitting(true);
    const res = await fetch("customers/upload", {
      method: "POST",
      body: new FormData(event.target),
      headers: {
          "X-CSRF-TOKEN": document.querySelector('[name=csrf-token]').content
      }
    });
    const data = await res.json();
    setSubmitting(false);
    if (data.hasOwnProperty("error")) {
      setResults(null);
      setError(data.error);
    } else {
      setResults(data.results);
      setError(null);
    }
  };

  return (
    <div className="columns mt-6 is-centered">
      <div className="column mx-6 is-half">
        {error &&
        <div className="notification is-danger is-light">{error}</div>
        }
        <form onSubmit={handleSubmit}>
          <div className="field">
              <label className="label">File</label>
              <div className="control">
                  <input className="input" type="file" name="file" placeholder="Data File"/>
              </div>
          </div>

          <div className="field">
              <label className="label">Sort</label>
              <div className="control">
                  <label className="radio">
                      <input type="radio" name="sort" value="vehicle_type" defaultChecked="true"/>
                      Vehicle Type
                  </label>
                  <label className="radio">
                      <input type="radio" name="sort" value="full_name"/>
                      Full Name
                  </label>
              </div>
          </div>

          <div className="field is-grouped is-grouped-centered mt-4">
              <div className="control">
                  <button className="button is-link" disabled={submitting}>Upload</button>
              </div>
          </div>
        </form>

        {results && 
        <Table results={results}></Table>
        }
      </div>
    </div>
  )
}

// Use if you don't plan to use "remount"
// document.addEventListener('DOMContentLoaded', () => {
//   ReactDOM.render(<Upload />, document.getElementById('upload'))
// })

export default Upload