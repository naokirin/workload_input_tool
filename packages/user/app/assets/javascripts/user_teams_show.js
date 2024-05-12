const load = function() {
    let checkboxes = document.querySelectorAll('input.checkbox');
    let selectedLabels = document.querySelectorAll('div.selected');
    let unselectedLabels = document.querySelectorAll('div.unselected');

    if (checkboxes.length === 0) {
        return;
    }

    if (checkboxes) {
        checkboxes.forEach((checkbox) => {
            checkbox.addEventListener('change', function(event) {
                let target = event.target;
                let selected = target.checked;
                let id = target.id;
                Array.from(selectedLabels).find(elm => elm.querySelector('div > label').htmlFor === id).classList.toggle('is-hidden', !selected);
                Array.from(unselectedLabels).find(elm => elm.querySelector('div > label').htmlFor === id).classList.toggle('is-hidden', selected);
            });
        });
    }
}

document.addEventListener('DOMContentLoaded', load);
