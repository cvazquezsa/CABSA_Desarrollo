
[Forma]
Clave=ExplorarCxCVentaNetaTotal
Icono=47
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Total General
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=282
PosicionInicialArriba=278
PosicionInicialAlturaCliente=118
PosicionInicialAncho=665
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcVentaNetaTotal
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
EspacioPrevio=S
[Lista.Impuestos]
Carpeta=Lista
Clave=Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.Total]
Carpeta=Lista
Clave=Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=N
Tamano=15
[Lista.Registros]
Carpeta=Lista
Clave=Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Lista.Columnas]
Importe=64
Impuestos=64
Total=64
Registros=64








[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=Excel(Total)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Excel
ClaveAccion=ExplorarCxcVentaNetaTotal
Activo=S
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=Registros
Registros=Importe
Importe=Impuestos
Impuestos=Total
Total=(Fin)













[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
