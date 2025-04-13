// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
// import 'controllers'

document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('searchInput')
  const resultsDiv = document.getElementById('results')
  const analyticsList = document.getElementById('analytics')

  let debounceTimeout

  // Real-time search with debouncing
  searchInput.addEventListener('input', () => {
    clearTimeout(debounceTimeout)
    const query = searchInput.value.trim()

    debounceTimeout = setTimeout(() => {
      if (query.length > 0) {
        fetch('/searches', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
              .content,
          },
          body: JSON.stringify({ query }),
        })
          .then((response) => response.json())
          .then((data) => {
            resultsDiv.innerHTML = `<p>Searching for: ${data.query}</p>`
            updateAnalytics()
          })
      }
    }, 300)
  })

  function updateAnalytics() {
    fetch('/analytics')
      .then((response) => response.json())
      .then((data) => {
        analyticsList.innerHTML = data
          .map(
            (item) => `
          <li>
            ${item.query} 
          </li>
        `
          )
          .join('')
      })
  }

  updateAnalytics()
})
