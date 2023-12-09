module.exports = {
  types: [
    {value: 'fix',      name: 'fix:      修复一个Bug'},
    {value: 'feat',     name: 'feat:     一个新的特性'},
    {value: 'docs',     name: 'docs:     变更的只有文档'},
    {value: 'style',    name: 'style:    空格, 分号等格式修复'},
    {value: 'refactor', name: 'refactor: 代码重构，注意和特性、修复区分开'},
    {value: 'perf',     name: 'perf:     提升性能'},
    {value: 'test',     name: 'test:     添加一个测试'},
    {value: 'chore',    name: 'chore:    变更构建流程或辅助工具'},
    {value: 'revert',   name: 'revert:   代码回退'}
    ],

  scopes: [{ name: 'Git' }],

  allowTicketNumber: false,
  isTicketNumberRequired: false,
  ticketNumberPrefix: 'TICKET-',
  ticketNumberRegExp: '\\d{1,5}',

  // it needs to match the value for field type. Eg.: 'fix'
  /*
  scopeOverrides: {
    fix: [
      {name: 'merge'},
      {name: 'style'},
      {name: 'e2eTest'},
      {name: 'unitTest'}
    ]
  },
  */
  // override the messages, defaults are as follows
  messages: {
    type: '选择一种你的提交类型:',
    scope: '选择一个scope (可选):',
    // used if allowCustomScopes is true
    customScope: '自定义scope:',
    subject: '填写简短精炼的变更描述：\n',
    body: '填写更加详细的变更描述（可选）。使用 "|" 换行：\n',
    breaking: '列举非兼容性重大的变更（可选）：\n',
    footer: '列举出所有变更的 ISSUES CLOSED（可选）。 例如: #31, #34：\n',
    confirmCommit: '确定提交说明?'
  },
  allowCustomScopes: true,
  allowBreakingChanges: ['fix', 'feat'],
  // skip any questions you want
  skipQuestions: ['breaking','footer'],

  // limit subject length
  subjectLimit: 100,
  breaklineChar: '|', // It is supported for fields body and footer.
  // footerPrefix : 'ISSUES CLOSED:', // default value
};
