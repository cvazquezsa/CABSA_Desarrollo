[Forma]
Clave=CRSucursal
Nombre=Sucursales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=390
PosicionInicialArriba=362
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Sucursal
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Sucursal<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Sucursal.Nombre
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Sucursales
IconosNombre=Sucursal:Sucursal.Sucursal

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=-2
1=-2

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Promocion]
Nombre=Promocion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Promociones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CRArtPromo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(Sucursal:Sucursal.Sucursal)
AntesExpresiones=Asigna(Info.Sucursal, Sucursal:Sucursal.Sucursal)<BR>Asigna(Info.Nombre, Sucursal:Sucursal.Nombre)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Promocion
Promocion=(Fin)
