[Forma]
Clave=MovGastoIndirecto
Nombre=Gastos Indirectos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=435
PosicionInicialArriba=324
PosicionInicialAlturaCliente=349
PosicionInicialAncho=409
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Mov, Info.MovID)
Totalizadores=S
PosicionSeccion1=89
ExpresionesAlMostrar=EjecutarSQL(<T>spMovGastoIndirectoSugerir :tEmpresa, :tModulo, :nID<T>, Empresa, Info.Modulo, Info.ID)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovGastoIndirecto
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
FiltroGeneral=MovGastoIndirecto.Modulo=<T>{Info.Modulo}<T> AND MovGastoIndirecto.ModuloID={Info.ID}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.MovGastoIndirecto.Concepto]
Carpeta=Lista
Clave=MovGastoIndirecto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovGastoIndirecto.Porcentaje]
Carpeta=Lista
Clave=MovGastoIndirecto.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concepto=304
Porcentaje=64

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

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
Totalizadores2=Suma(MovGastoIndirecto:MovGastoIndirecto.Porcentaje)
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
(Inicio)=MovGastoIndirecto.Concepto
MovGastoIndirecto.Concepto=MovGastoIndirecto.Porcentaje
MovGastoIndirecto.Porcentaje=(Fin)
