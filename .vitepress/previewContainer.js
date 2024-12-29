import MarkdownItContainer from 'markdown-it-container';

export default function previewContainer(md) {
  md.use(MarkdownItContainer, 'preview', {
    validate(params) {
      return params.trim().match(/^preview/);
    },
    render(tokens, idx) {
      var m = tokens[idx].info.trim().match(/^preview\s+(.*)$/);
      debugger
      console.log('======', m, m && m.length > 0 ? m[1] : '')
      if (tokens[idx].nesting === 1) {
        // opening tag
        return `<CodeSimulator class="code" src="${m && m.length > 0 ? m[1] : ''}">`;
        // return `<div class="---------">`;
      } else {
        // closing tag
        return `</CodeSimulator>`;
        // return `</div>`;
      }
    }
  });
}