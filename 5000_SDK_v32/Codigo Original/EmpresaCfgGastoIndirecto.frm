[Forma]
Clave=EmpresaCfgGastoIndirecto
Nombre=Gastos Indirectos - Entrada Producto (Inventario)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=436
PosicionInicialArriba=294
PosicionInicialAlturaCliente=409
PosicionInicialAncho=407
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Empresa
Totalizadores=S
PosicionSeccion1=91

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgGastoIndirecto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=EmpresaCfgGastoIndirecto.Empresa=<T>{Empresa}<T>

[Lista.EmpresaCfgGastoIndirecto.Concepto]
Carpeta=Lista
Clave=EmpresaCfgGastoIndirecto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgGastoIndirecto.Porcentaje]
Carpeta=Lista
Clave=EmpresaCfgGastoIndirecto.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Concepto=304
Porcentaje=64

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
Totalizadores2=Suma(EmpresaCfgGastoIndirecto:EmpresaCfgGastoIndirecto.Porcentaje)
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
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgGastoIndirecto.Concepto
EmpresaCfgGastoIndirecto.Concepto=EmpresaCfgGastoIndirecto.Porcentaje
EmpresaCfgGastoIndirecto.Porcentaje=(Fin)
