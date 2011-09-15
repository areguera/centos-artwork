<?php
/**
 * Categories related functions
 *
 */


//--------/* Get Category Name */

function get_category_name( $category_id )
{
    global $db;
    if ( preg_match('/^[0-9]+$/', $category_id ) )
    {
        $category_id = pg_escape_string( $category_id );
        $sql_string = "SELECT name, parent FROM categories WHERE id=" . $category_id . ";";
        $source = $db->query( $sql_string );
        $category = pg_fetch_array($source);

        if ( ! $category['name'] )
        {
            $category['name'] = 'No';
        }
    }

    return $category['name'];
}

//-------/* Get Admin Categories Selector 
         /* (used in category administration) */

function get_category_selector( $category_id = null, $category_parent_id = null, $type = 'insert' )
{
    global $db;

    $sql_string = "SELECT id, name, parent FROM categories;"; 
    $rows = $db->query( $sql_string );

    $html  = '<select name="parent">';
    $html .= '<option value="0"> </option>';

    while ( $row = pg_fetch_array( $rows ) )
    {
        switch ($type)
        {
            case 'update':
                if ( isset( $category_id )  && $row['id'] != $category_id )
                {
                    if ( isset( $category_parent_id ) && $row['id'] == $category_parent_id )
                    {
                        $html .= '<option selected value="'.$row['id'].'">'.$row['name'].'</option>';
                    }
                    else
                    {
                        $html .= '<option value="'.$row['id'].'">'.$row['name'].'</option>';
                    }
                }
            break;

            default:
                $html .= '<option value="'.$row['id'].'">'.$row['name'].'</option>';
            break;

        }

    }

    $html .= '</select>'; 

    return $html;
}

//-------/* Get Admin Categories Form

function get_categories_admin_form( $rows )
{
    $html = '<form action="" method="post" name="categories_admin">';
    $html .= '<div class="action alignr">';
    $html .=  show_action_field('delete');
    $html .= '<input type="submit" name="categoriesadmin" value="' . ucfirst(translate('accept')). '" />';
    $html .= '</div>';

    $html .= '<table>';
    $html .= '<tr>';
    $html .= '<th class="firstcol"></th>';
    $html .= '<th style="width:200px">' . ucfirst(translate('name')) . '</th>';
    $html .= '<th style="width:200px">' . ucfirst(translate('parent category')) . '</th>';
    $html .= '<th>' . ucfirst(translate('description')) . '</th>';
    $html .= '</tr>';

    // Loop throuh rows
    while ( $row = pg_fetch_array($rows) )
    {
        $html .= '<tr>';
        $html .= '<td><input type="checkbox" name="id['.$row['id'].']" value="'.$row['id'].'" /></td>';
        $html .= '<td><a href="?page=categories&action=update&id='.$row['id'].'">'.$row['name'].'</a></td>';
        $html .= '<td class="alignc">'. get_category_name($row['id']) .'</td>';
        $html .= '<td>'.$row['description'].'</td>';
        $html .= '</tr>';
    }

    $html .= '</table>';

    $html .= '<div class="action alignr">';
    $html .= '<input type="submit" name="categoriesadmin" value="' . ucfirst(translate('accept')). '" />';
    $html .= '</div>';
    $html .= '</form>';

    return $html;
}

//-------/* Get Add Categories Form

function get_categories_add_form()
{
    $html = '<div class="formfields">';
    $html .= '<form action="" method="post" name="categories_add">';
    $html .= '<ul>';
    $html .= '<li class="description">' . translate('Name') . '</li>';
    $html .= '<li class="value"><input type="text" name="name" value="" size="30" /></li>';
    $html .= '<li class="description">' . ucfirst( translate('parent category') ) . '</li>';
    $html .= '<li class="value">' . get_category_selector() . '</li>';
    $html .= '<li class="description">' . translate('Description') . '</li>';
    $html .= '<li class="value"><textarea name="description" cols="50" rows="6"></textarea></li>';
    $html .= '<li class="submit"><input type="submit" name="add_categories" value="'. ucfirst(translate('add')) .'" /></li>';
    $html .= '</ul>';
    $html .= '<input type="hidden" name="action" value="add" />';
    $html .= '</form>';
    $html .= '</div>';

    return $html;
}

//-------/* Get Update Categories Form

function get_categories_update_form()
{
    global $db;

    if ( sanitize_url_var( 'id' ) ) 
    {
        $clean['id'] = $_GET['id']; 
        $sql_string = "SELECT id, name, parent, description FROM categories WHERE id=" . $clean['id'] . ";";
        $row = $db->query( $sql_string );

        if ( $row !== false )
        {
            $row = pg_fetch_array($row);

            $html = '<div class="formfields">';
            $html .= '<form action="" method="post" name="categories_update">';
            $html .= '<ul>';
            $html .= '<li class="description">' . translate('Name') . '</li>';
            $html .= '<li class="value"><input type="text" name="name" value="' . $row['name'] . '" size="30" /></li>';
            $html .= '<li class="description">' . ucfirst(translate('parent category')) . '</li>';
            $html .= '<li class="value">'. get_category_selector( $row['id'], $row['parent'], 'update').'</li>';
            $html .= '<li class="description">' . translate('Description') . '</li>';
            $html .= '<li class="value"><textarea name="description" cols="50" rows="6">'. $row['description']  .'</textarea></li>';
            $html .= '<li class="submit"><input type="submit" name="update_categories" value="'. ucfirst(translate('update')) .'" /></li>';
            $html .= '</ul>';
            $html .= '<input type="hidden" name="action" value="update" />';
            $html .= '</form>';
            $html .= '</div>';
        }
        else
        {
            $html = show_message( ucfirst( translate("the category doesn't exist") ) , 'orange'); 
        }
    }
    else
    {
        $html = show_message( ucfirst( translate('nothing to do') ) , 'orange'); 
    }

    return $html;
}

//-------/* Administrate Categories

function admin_categories()
{
    global $db;

    $fields = array('id', 'name', 'parent', 'description');
    $counter = 0;

    // Define action to do
    if (isset($_POST['action']) && preg_match('/^(update|delete|add)$/', $_POST['action']))
    {
        $action = $_POST['action'];

        switch ( $action )
        {
            case 'update':

                // Initialize FORM variables 
                foreach ( $fields as $key )
                {
                    if ( isset( $_POST[$key] ) && $_POST[$key] != '' )
                    {
                        $clean[$key] = pg_escape_string($_POST[$key]);
                    }
                    else
                    {
                        $clean[$key] = '';
                    }
                }


                // Required fields
                if ( $clean['name'] == '' )
                {
                    $message = show_message(ucfirst(translate('field name can not be empty')),'orange');
                    return $message;
                }

                // Verify and redifine category indentification
                if ( sanitize_url_var( 'id' ) )
                {
                    $clean['id'] = $_GET['id'];
                }


                // Build sql string for updating
                $sql_string = "UPDATE categories SET name='" . $clean['name'] . "', description='" . $clean['description'] . "' WHERE id=" . $clean['id'] . ";";
echo $sql_string;
                // Execute UPDATE action
                $db->query( $sql_string );

                // Define message for successful action 
                $message = show_message( ucfirst( translate('data was updated successfully' ) ), 'green');

            break;

            case 'delete':

                if ( isset( $_POST['id'] ) )
                {
                    foreach ( $_POST['id'] as $key )
                    {
                        if ( preg_match( '/^[0-9]+$/', $key ) )
                        {
                            // Check for dependencies for actual category id
                            // ...

                            // Build SQL string for deleting
                            $sql_string = "DELETE FROM categories WHERE id=" . $key . ";";

                            // Execute DELETE action
                            if ( $db->query( $sql_string ) )
                            {
                                $counter++;
                            }
                        }
                        else
                        {
                            // Build message for failed action
                            $message = show_message(ucfirst(translate('id value is incorrect')));
                            return $message;
                        }
                    }

                    // Build message for successful action (with plural distinction)
                    if ( $counter > 1 )
                    {
                        $message = $counter . ' ' . translate('records deleted successfully');
                    }
                    else
                    {
                        $message = $counter . ' ' . translate('record deleted successfully');
                    }
                    $message = show_message( $message, 'green');
                }
            break;

            case 'add':
    
                $fields = array('name', 'parent', 'description'); 

                // Initialize and prepare input values for db insertion
                foreach ( $fields as $key)
                {
                    if ( isset( $_POST[$key] ) )
                    {
                        $clean[$key] = pg_escape_string($_POST[$key]);
                    }
                    else
                    {
                        $clean[$key] = '';
                    }
                }

               // Required fields
               if ( $clean['name'] == '' )
               {
                    $message = show_message(ucfirst(translate('field name can not be empty')),'orange');
                    return $message;
               }

               // Build sql string for inserting
               $sql_string = "INSERT INTO categories (name, parent, description) 
                                    VALUES ('".$clean['name']."', '" . $clean['parent']. "', '" .$clean['description']."');";

               // Execute INSERT action
               if ( $db->query( $sql_string ) )
               {
                    // Build message for successful action
                    $message = show_message(ucfirst(translate('category was added successfully')),'green');
               }
               else
               {
                    // Build message for failed action
                    $message = show_message(ucfirst(translate('category was not added')),'orange');
               }
               break;
        }

        // Define default informative message if no action is present 
        if ( ! isset( $message ) )
        {
            $message = show_message(ucfirst(translate('nothing to do')), 'orange');
        }

        // Return informative action message
        return $message;

    }

    // Return false if no action is present
    return false;
}


//--------/* Get Category Tree */

function get_category_tree( $parent = 0, $linkto = 'default' )
{

    global $db;
    $sql_string = "SELECT id, name, parent FROM categories WHERE parent = ". $parent ." ORDER BY name;";
    $categories = $db->query($sql_string); 
    $html = '';

    $html .= '<ul class="category_tree">';
    while ( $row = pg_fetch_array($categories) )
    {
        switch ( $linkto )
        {
            case 'admin':
                $html .= '<li><a href="?page=categories&action=update&id='.$row['id'].'">' . $row['name'] . '</a></li>';
                break;

            default:
                $html .= '<li><a href="?page=posts&sort=categories&id='.$row['id'].'">' . $row['name'] . '</a></li>';
                break;

        }
        $html .= get_category_tree( $row['id'] , $linkto );
    }
    $html .= '</ul>';

    return $html;
}
