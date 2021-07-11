$bfr_folder = 'E:\TestingCOde\TestBuffer\' # folder to distribute plots from 
$farm_hdd_destinations = @('E:\TestingCOde\Folder1','E:\TestingCOde\Folder2','E:\TestingCOde\Folder3', 'E:\TestingCOde\Folder4') # Destination folders

$destindex = 0 # start with the first path in $farm_hdd_destinations
#$plotindex = 0 # plot index iterative
$check_interval = 5 # in seconds

while($true)
{

    $plot_files = Get-ChildItem -path $bfr_folder *.txt
    write-host $plot_files
    write-host $plot_files.length
    
    if ($destindex -gt $farm_hdd_destinations.length){
        $destindex = 0
    }

    if ($plot_files.length -gt 0){
        if ($destindex -le $($farm_hdd_destinations.length)){
        
            #foreach ($plot in $plot_files) {
            for ($i = 0; $i -lt $plot_files.length; $i++) { #iterates through plot files array
            
                $tempdir = $($bfr_folder)+$($plot_files[$i]) #concats plot files to buffer dir

                move-item $tempdir -Destination $farm_hdd_destinations[$destindex]
                $destindex++
                write-host "destindex = " $destindex
                

                if ($destindex -gt $farm_hdd_destinations.length){
                    $destindex = 0
                }
            }
        }
        #}else{
        
        #$destindex = 0

        #}
    }else{
        move $bfr_folder*.txt $farm_hdd_destinations[$index]
        $index++
    }
    start-sleep $check_interval

}