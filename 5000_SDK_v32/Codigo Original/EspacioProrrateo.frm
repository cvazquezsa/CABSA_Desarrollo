[Forma]
Clave=EspacioProrrateo
Nombre=Prorrateo Indirectos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Concepto
ListaAcciones=Aceptar
PosicionInicialIzquierda=339
PosicionInicialArriba=159
PosicionInicialAlturaCliente=416
PosicionInicialAncho=345
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=91

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EspacioProrrateo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.EspacioProrrateo.Rol]
Carpeta=Lista
Clave=EspacioProrrateo.Rol
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Rol=160
CentroCostos=83
Porcentaje=39
Descripcion=213
Espacio=105
Nombre=178
Servicio=128
Rol_1=87

[Lista.EspacioProrrateo.Porcentaje]
Carpeta=Lista
Clave=EspacioProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EspacioProrrateo.Espacio]
Carpeta=Lista
Clave=EspacioProrrateo.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=% Total
Totalizadores2=Suma(EspacioProrrateo:EspacioProrrateo.Porcentaje)
Totalizadores3=0.00
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=% Total
CarpetaVisible=S

[(Carpeta Totalizadores).% Total]
Carpeta=(Carpeta Totalizadores)
Clave=% Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=EspacioProrrateo.Rol
EspacioProrrateo.Rol=EspacioProrrateo.Espacio
EspacioProrrateo.Espacio=EspacioProrrateo.Porcentaje
EspacioProrrateo.Porcentaje=(Fin)
