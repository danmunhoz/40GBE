$(document).ready(function(){
    $("div[id='form_rfc']").hide();
    $("div[id='form_rfc'] :input").prop('disabled', true);
    $("div[id='form_timed_throughput']").hide();
    $("div[id='form_timed_throughput'] :input").prop('disabled', true);
    $("div[id='form_loopback']").hide();
    $("div[id='form_loopback'] :input").prop('disabled', true);

//     Switch forms for different tests
    $("select[name*='test_selector']").change(function() {
        var parent = jQuery(this).parent();
        scheduled = parent.siblings().find(":checkbox[name*=scheduled]");
        switch(jQuery(this).val()){
            case "1":
                parent.siblings("div[id='form_rfc']").show();
                parent.siblings("div[id='form_rfc']").find(":input").prop('disabled', false);
                parent.siblings("div[id='form_timed_throughput']").hide();
                parent.siblings("div[id='form_timed_throughput']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_loopback']").hide();
                parent.siblings("div[id='form_loopback']").find(":input").prop('disabled', true);
                scheduled.prop('checked', true);
                break;
            case "2":
                parent.siblings("div[id='form_rfc']").hide();
                parent.siblings("div[id='form_rfc']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_timed_throughput']").show();
                parent.siblings("div[id='form_timed_throughput']").find(":input").prop('disabled', false);
                parent.siblings("div[id='form_loopback']").hide();
                parent.siblings("div[id='form_loopback']").find(":input").prop('disabled', true);
                scheduled.prop('checked', true);
                break;
            case "3":
                parent.siblings("div[id='form_rfc']").hide();
                parent.siblings("div[id='form_rfc']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_timed_throughput']").hide();
                parent.siblings("div[id='form_timed_throughput']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_loopback']").show();
                parent.siblings("div[id='form_loopback']").find(":input").prop('disabled', false);
                scheduled.prop('checked', true);
                break;

            default:
                parent.siblings("div[id='form_rfc']").hide();
                parent.siblings("div[id='form_rfc']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_timed_throughput']").hide();
                parent.siblings("div[id='form_timed_throughput']").find(":input").prop('disabled', true);
                parent.siblings("div[id='form_loopback']").hide();
                parent.siblings("div[id='form_loopback']").find(":input").prop('disabled', true);
                scheduled.prop('checked', false);
                break;
        }
    });

    $(":checkbox[name*='ps']").change(function() {
        if(!this.checked) {
            jQuery(this).closest("div[class*='packet_sizes']").find(":checkbox[name='ALL_PACKET_SIZES']").prop('checked', false);
        }
    });
    $(":checkbox[name='ALL_PACKET_SIZES']").change(function() {
        if(this.checked) {
            jQuery(this).closest("div[class*='packet_sizes']").find(":checkbox[name*='ps']").prop('checked', true);
        } else {
            jQuery(this).closest("div[class*='packet_sizes']").find(":checkbox[name*='ps']").prop('checked', false);
        }
    });

    $("button[id='submit']").click(function() {
        $("form").each(function(){
            if(jQuery(this).find(":checkbox[name*='scheduled']").prop('checked')){
                this.submit();
            }
        });
    });

    $(":checkbox[name*='scheduled']").change(function() {
        var parent = jQuery(this).closest("div.row");
        var select = parent.find("select[name*='test_selector']");
        if(this.checked){
            select.prop('disabled', false);
            select.trigger("change");
        } else {
            select.prop('disabled', true);
            parent.find("div[id*='form_']").hide();
        }
    });

    $("button.print").click(function() {
        jQuery(this).hide();
        $('div#jobs').hide();
        window.print();
        $('div#jobs').show();
        jQuery(this).show();
    });

    $("input[name*=mac_destination]").mask('AA:AA:AA:AA:AA:AA', {placeholder: "Destination MAC (Hex)"});
    $("input[name*=mac_source]").mask('AA:AA:AA:AA:AA:AA', {placeholder: "Source MAC (Hex)"});

    $("div#jobs").load("/ajax/jobs");
    setInterval(function() {
        $("div#jobs").load("/ajax/jobs");
    }, 1000);

    var checkLinkStatus = function() {
        $.getJSON("/ajax/status", function(result){
            $.each(result, function(i, field){
                var scheduled_checkbox = $(":checkbox[name*='scheduled']:eq(".concat(i,")"));
                var parent = jQuery(scheduled_checkbox).closest("div.row");
                var select = parent.find("select[name*='test_selector']");
                if (field) {
                    if (scheduled_checkbox.prop("disabled")){
                        scheduled_checkbox.prop("disabled", false);
                        select.prop('disabled', false);
                        select.trigger("change");
                    }
                } else {
                    if (! scheduled_checkbox.prop("disabled")){
                        scheduled_checkbox.prop("checked", false).prop("disabled", true);
                        select.prop('disabled', true);
                        parent.find("div[id*='form_']").hide();
                    }
                }
            });
        });
    }
    checkLinkStatus();
    setInterval(checkLinkStatus, 1000);

    $("select[name*='payload_selector']").change(function() {
        switch(jQuery(this).val()){
            case "1":
                $("select[name*='polynome_selector']").show();
                break;

            default:
                $("select[name*='polynome_selector']").hide();
                break;
        }
    });
});