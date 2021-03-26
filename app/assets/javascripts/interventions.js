$(document).ready(function () {

    var value = "";
    var data; 

    hideBuilding()


    $('#customers').change(async function (event){
        event.stopImmediatePropagation();
        value = $(this).val()
        if (value ==="") {
            hideBuilding()
        } else {
            $('#buildings').show()
            let buildings = [new Option("Select a building", "")]
            data = await getData(value, "building")
            data.forEach((element) => {buildings.push(new Option(`${element.full_name_of_the_technical_contact_for_the_building}, Building ID: ${element.id}`, element.id))})
            $('#buildings').html(buildings)
        }
    });


    $('#buildings').change(async function (event){
        event.stopImmediatePropagation();
        value = $(this).val()
        if (value ==="") {
            hideBattery()
        } else {
            $('#batteries').show()
            let batteries = [new Option("Select a battery", "")]
            data = await getData(value, "battery")
            data.forEach((element) => {batteries.push(new Option(`Battery ID: ${element.id}`, element.id))})
            $('#batteries').html(batteries)
        }
    });

    $('#batteries').change(async function (event){
        event.stopImmediatePropagation();
        value = $(this).val()
        if (value ==="") {
            hideColumn()
        } else {
            $('#columns').show()
            let columns = [new Option("Select a column", "")]
            data = await getData(value, "column")
            data.forEach((element) => {columns.push(new Option(`Column ID: ${element.id}`, element.id))})
            $('#columns').html(columns)
        }
    });

    $('#columns').change(async function (event){
        event.stopImmediatePropagation();
        value = $(this).val()
        if (value ==="") {
            hideElevator()
        } else {
            $('#elevators').show()
            let elevators = [new Option("Select a elevator", "")]
            data = await getData(value, "elevator")
            data.forEach((element) => {elevators.push(new Option(`Elevator ID: ${element.id}`, element.id))})
            $('#elevators').html(elevators)
        }
    });


    function hideBuilding() {
        $('#buildings').hide()
        hideBattery()
    }

    function hideBattery() {
        $('#batteries').hide()
        hideColumn()
    }

    function hideColumn() {
        $('#columns').hide()
        hideElevator()
    }

    function hideElevator() {
        $('#elevators').hide()
    }


    async function getData(id, value){
        const data = await $.ajax({
            type: "GET",
            url: `/ajax/GetData?id=${id}&value=${value}`,
        })
        return data
    }

});