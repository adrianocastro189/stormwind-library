-- uncomment the following line if this is needed in the future
-- function postprocess_html(html)
    -- removes the "last updated <i> tag at the documentation folder
    -- example: <i style="float:right;">Last updated 2024-04-27 16:27:57 </i>
    -- this is good to avoid many .html changes for each commit when the ldoc
    -- generator is executed
    -- return html:gsub('<i%s+style="float:right;">Last%s+updated%s+[%d%-: ]+%s+</i>\n', '')
-- end

sort=true
-- uncomment the following line if this is needed in the future
-- postprocess_html=postprocess_html