const cds = require('@sap/cds')

module.exports = class EmployeeService extends cds.ApplicationService { init() {

  const { Employees } = cds.entities('EmployeeService')

  this.before (['CREATE', 'UPDATE'], Employees, async (req) => {
    console.log('Before CREATE/UPDATE Employees', req.data)
  })
  this.after ('READ', Employees, async (employees, req) => {
    console.log('After READ Employees', employees)
  })
  this.before ('CREATE', Employees, async (req) => {
    const employee = req.data;

    if (employee.salaryAmount > 50000 & employee.currency_code != 'USD') {
      req.reject(409, `Employee's salary must be less then 50000 USD. \n salary : ${employee.salaryAmount} `)
    }
  })
  this.after('CREATE', Employees, async (result, req) => {
    console.log('Create Operation successful', result)
  })
  this.before ('UPDATE', Employees, async (req) => {
    const incoming = req.data;
    const outcoming = await cds.tx(req).run(
      SELECT.one.from(Employees).where({ID: incoming.ID})
    )
    if (outcoming.nameFirst != incoming.nameFirst || outcoming.loginName != incoming.loginName ){
      req.reject(409, `This operation isn't allowed`)
    }
  })
  this.after('UPDATE', Employees, async (result, req) => {
    console.log('UPDATE Operation successful', result)
  })
  this.before('DELETE', Employees, async (req) => {
    const existing = await cds.tx(req).run(
      SELECT.one.from(Employees).where({ID: req.params[0].ID})
    )
    if (!existing) {
      req.reject(404, `Employee not found with ${ req.params[0].ID }`)
    }
    const firstLetter = existing.nameFirst?.charAt(0);

    if (firstLetter && firstLetter.toUpperCase() === 'S') {
      req.reject(403, `You can't perform delete operation.`)
    }
  })
  this.after('DELETE', Employees, async (result, req) => {
    console.log('record removed', result)
  })

  return super.init()
}}
