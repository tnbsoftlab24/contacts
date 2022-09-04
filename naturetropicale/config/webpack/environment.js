const { environment } = require('@rails/webpacker')
const webpack = require('webpack')


// resolve-url-loader must be used before sass-loader
// environment.loaders.get('sass').use.splice(-1, 0, {
//     loader: 'resolve-url-loader',
//     options: {
//         attempts: 1
//     }
// });

environment.plugins.append('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        jquery: 'jquery',
        'window.jQuery': 'jquery',
        Popper: ['popper.js', 'default'],
        // Popper: ['popper.js', 'default']
    })
)


// const aliasConfig = {
//     'jquery': 'jquery/src/jquery',
//     'jquery-ui': 'jquery-ui-dist/jquery-ui.js'

// };

// environment.config.set('resolve.alias', aliasConfig);

// module.exports = {
//     module: {
//         rules: [{
//             test: /\.css$/i,
//             use: ['to-string-loader', 'css-loader'],
//         }, ],
//     },
// };
module.exports = environment