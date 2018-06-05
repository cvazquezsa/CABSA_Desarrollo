
[Forma]
Clave=SincroHerComparacion
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=642
PosicionInicialArriba=370
PosicionInicialAlturaCliente=121
PosicionInicialAncho=315
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Comparación de Sincronización
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S




Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion={EstacionTrabajo}
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S






[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107
















































[Ficha.RepParam.InfoServidor1]
Carpeta=Ficha
Clave=RepParam.InfoServidor1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoBaseDatos1]
Carpeta=Ficha
Clave=RepParam.InfoBaseDatos1
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoServidor2]
Carpeta=Ficha
Clave=RepParam.InfoServidor2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoBaseDatos2]
Carpeta=Ficha
Clave=RepParam.InfoBaseDatos2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoServidor1
RepParam.InfoServidor1=RepParam.InfoBaseDatos1
RepParam.InfoBaseDatos1=RepParam.InfoServidor2
RepParam.InfoServidor2=RepParam.InfoBaseDatos2
RepParam.InfoBaseDatos2=(Fin)










[Acciones.Aceptar]
Nombre=Aceptar
Boton=88
NombreEnBoton=S
NombreDesplegar=Aceptar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SincroComparacion
Activo=S
Visible=S











Antes=S




















































































AntesExpresiones=EjecutarSQL( <T>EXEC spComprararEstructuraDB :nEstacion<T>, EstacionTrabajo)






[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
