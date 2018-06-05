[Forma]
Clave=EspecificarTarimaWMS
Nombre=<T>Especificar Tarima<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraAcciones=S
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionInicialIzquierda=590
PosicionInicialArriba=304
PosicionInicialAltura=108
PosicionInicialAncho=241
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=79
VentanaSiempreAlFrente=S
VentanaEstadoInicial=Normal

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=62
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.Tarima
CarpetaVisible=S

[(Variables).Info.Tarima]
Carpeta=(Variables)
Clave=Info.Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
NombreDesplegar=&Aceptar
EnBarraAcciones=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
NombreDesplegar=Cancelar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




























[Acciones.Aceptar.AsignaVariables]
Nombre=AsignaVariables
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spWMSActualizarTarima :nEstacionTrabajo, :tAlmacen, :tArticulo, :tSubCuenta, :tPosicion, :tTarima<T>, EstacionTrabajo, Info.Almacen, Info.Articulo, Info.SubCuenta, Info.Posicion, Info.Tarima)     <BR>ActualizarForma



[Lista.Columnas]
0=125
1=129
2=-2
3=-2
4=-2




[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=AsignaVariables
AsignaVariables=Aceptar
Aceptar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
