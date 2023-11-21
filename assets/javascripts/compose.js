document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('seven_compose');
    const filters = [form.elements.namedItem('filter_admin'), form.elements.namedItem('filter_groups')];

    form.elements.namedItem('to').addEventListener('change', e => {
        filters.forEach(f => f.disabled = '' !== e.target.value)
    });
});