[Forma]
Clave=CteCapacidadPago
Nombre=Capacidad Pago del Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=211
PosicionInicialArriba=135
PosicionInicialAlturaCliente=464
PosicionInicialAncho=601
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Cliente
Totalizadores=S
PosicionSeccion1=92
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteCapacidadPago
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
OtroOrden=S
ListaOrden=(Lista)
FiltroGeneral=CteCapacidadPago.Cliente=<T>{Info.Cliente}<T>

[Lista.CteCapacidadPago.Concepto]
Carpeta=Lista
Clave=CteCapacidadPago.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCapacidadPago.Ingreso]
Carpeta=Lista
Clave=CteCapacidadPago.Ingreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteCapacidadPago.Egreso]
Carpeta=Lista
Clave=CteCapacidadPago.Egreso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.Columnas]
Concepto=304
Ingreso=132
Egreso=124

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
Totalizadores1=Ingresos<BR>Egresos<BR>Capacidad Pago
Totalizadores2=Suma(CteCapacidadPago:CteCapacidadPago.Ingreso)<BR>Suma(CteCapacidadPago:CteCapacidadPago.Egreso)<BR>(Suma(CteCapacidadPago:CteCapacidadPago.Ingreso) - Suma(CteCapacidadPago:CteCapacidadPago.Egreso))*Config.ACFactorCapacidadPago 
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Ingresos]
Carpeta=(Carpeta Totalizadores)
Clave=Ingresos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Egresos]
Carpeta=(Carpeta Totalizadores)
Clave=Egresos
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Capacidad Pago]
Carpeta=(Carpeta Totalizadores)
Clave=Capacidad Pago
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CteCapacidadPago.Concepto
CteCapacidadPago.Concepto=CteCapacidadPago.Ingreso
CteCapacidadPago.Ingreso=CteCapacidadPago.Egreso
CteCapacidadPago.Egreso=(Fin)

[Lista.ListaOrden]
(Inicio)=CteCapacidadPago.Ingreso<TAB>(Decendente)
CteCapacidadPago.Ingreso<TAB>(Decendente)=CteCapacidadPago.Egreso<TAB>(Decendente)
CteCapacidadPago.Egreso<TAB>(Decendente)=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Ingresos
Ingresos=Egresos
Egresos=Capacidad Pago
Capacidad Pago=(Fin)
