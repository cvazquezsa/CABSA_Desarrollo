
[Forma]
Clave=ExplorarDineroModuloTotal
Icono=47
Modulos=(Todos)
Nombre=Total General

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=100
PosicionInicialAncho=451
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=560
PosicionInicialArriba=286
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ExplorarDineroModuloTotal
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Lista.ImporteTotalNeto]
Carpeta=Lista
Clave=ImporteTotalNeto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[Lista.ImporteTotalNetoMN]
Carpeta=Lista
Clave=ImporteTotalNetoMN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


EspacioPrevio=N
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
ClaveAccion=ExplorarDineroModuloTotal
Activo=S
Visible=S















[Lista.Registros]
Carpeta=Lista
Clave=Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Lista.ListaEnCaptura]
(Inicio)=Registros
Registros=ImporteTotalNeto
ImporteTotalNeto=ImporteTotalNetoMN
ImporteTotalNetoMN=(Fin)

















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Excel
Excel=(Fin)
