{extends file='layouts/default.tpl'}

{block name=title}Sample Product Page{/block}

{block name=head}<meta name="description" content="An example file-based theme page."></meta>{/block}

{block name=content}
    <section class="container">
        <h1>Sample Product Page</h1>
        <p>
            This page is served from <code>views/page/sample-product-page.tpl</code>
            at <code>/sample-product-page</code>. No controller and no route are
            needed; drop the file under <code>views/page/</code> and the page works.
        </p>
        <p>
            It is a normal theme view: it extends the layout, so the header and
            footer come automatically, and it can use <code>{ldelim}lang{rdelim}</code>,
            <code>{ldelim}link{rdelim}</code>, <code>{ldelim}config{rdelim}</code> like any other page.
        </p>
        <p><a href="{link route='home'}">Back to home</a></p>
    </section>
{/block}
