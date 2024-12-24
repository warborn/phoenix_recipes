import Autocomplete from '@trevoreyre/autocomplete-js'

const AddressAutocompleteHook = {
  mounted() {
    this.autocomplete = new Autocomplete(this.el, {
      search: input => {
        const url = `/api/address/query?place=${encodeURIComponent(input)}`;

        return new Promise(resolve => {
          if (input.length === 0) {
            return resolve([]);
          }
          if (input.length < 3) {
            return resolve([])
          }

          return fetch(url, {
            headers: {
              "Content-Type": "application/json",
            }
          }).then(response => response.json()).then((data) => {
            return resolve(data.data);
          })
        })
      },
      onSubmit: result => {
        this.pushEventTo(this.el, "address-selected", { place_id: result.place_id });
      },
      getResultValue: result => result.description,
      renderResult: (result, props) => {
        return `
        <li ${props}>
          <span className="block truncate">${result.description}</span>
        </li>
      `},
      debounceTime: 500
    })
  },
  destroyed() {
    this.autocomplete.destroy();
  }
}

export default AddressAutocompleteHook;