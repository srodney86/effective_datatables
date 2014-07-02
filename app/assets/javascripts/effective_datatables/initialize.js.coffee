initializeDataTables = ->
  $('table[data-effective-datatables-table]').each ->
    unless $.fn.DataTable.fnIsDataTable(this)
      datatable = $(this)

      datatable.dataTable
        bServerSide: true
        bProcessing: true
        bSaveState: true
        sAjaxSource: datatable.data('source')
        sPaginationType: "bootstrap"
        aLengthMenu: [[10, 25, 50, 100, 250, 1000, -1], [10, 25, 50, 100, 250, 1000, 'All']]
        aoColumnDefs: 
          [
            {
              sDefaultContent: '-',
              aTargets: ['_all']
            },
            {
             bSortable: false,
             aTargets: datatable.data('non-sortable')
            },
            {
             bVisible: false,
             aTargets: datatable.data('non-visible')
            }
          ]
        oTableTools:
          sSwfPath: '/assets/effective_datatables/copy_csv_xls_pdf.swf',
          aButtons: ['copy', 'csv', 'pdf', 'print']
        colVis:
          showAll: 'Show all'

      .columnFilter
        sPlaceHolder: 'head:after'
        aoColumns : datatable.data('filter')
        bUseColVis: true

  $('.dataTables_filter').each ->
    $(this).html("<button class='btn-reset-filters ColVis_Button' data-effective-datatables-reset-filters='true'><span>Reset Filters</span></button>")

$ -> initializeDataTables()
$(document).on 'page:change', -> initializeDataTables()

$(document).on 'click', '[data-effective-datatables-reset-filters]', (event) -> 
  #dataTable = $(this).closest('dataTables_wrapper').find('table').dataTable()
  window.location.reload()
