[Forma]
Clave=VentaCobroD
Nombre=<T>Cobro - <T>+Afectar.Mov
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=219
PosicionInicialArriba=194
PosicionInicialAltura=385
PosicionInicialAncho=642
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Si<BR>  Vacio(VentaCobroD:VentaCobroD.ID) y (no Info.Cerrado)<BR>Entonces<BR>  Asigna(Temp.Monetario, SQL(<T>SELECT -ISNULL(Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = :tEmpresa AND Cliente = :tCliente AND Moneda = :tMoneda<T>, Empresa, Info.Cliente, Info.Moneda))<BR>  Si(Temp.Monetario>Info.Importe, Asigna(Temp.Monetario, Info.Importe))<BR>  Si(Temp.Monetario>0, Asigna(VentaCobroD:VentaCobroD.Importe, Temp.Monetario))<BR>  Asigna(VentaCobroD:VentaCobroD.Importe, Info.Importe-Temp.Monetario)<BR>Fin<BR>Info.Moneda
ListaAcciones=(Lista)
Totalizadores=S
PosicionSeccion1=89
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.VerDetalles, Falso)
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCobroD
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=VentaCobroD.ID={Info.ID}

[Lista.VentaCobroD.Importe]
Carpeta=Lista
Clave=VentaCobroD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaCobroD.Moneda]
Carpeta=Lista
Clave=VentaCobroD.Moneda
Editar=S
IgnoraFlujo=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaCobroD.TipoCambio]
Carpeta=Lista
Clave=VentaCobroD.TipoCambio
Editar=S
IgnoraFlujo=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaCobroD.FormaCobro]
Carpeta=Lista
Clave=VentaCobroD.FormaCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaCobroD.Referencia]
Carpeta=Lista
Clave=VentaCobroD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Importe=124
Moneda=67
TipoCambio=64
FormaCobro=95
Referencia=151
ImporteNeto=98

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
Menu=&Archivo
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
ActivoCondicion=no Info.Cerrado

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
Totalizadores1=Total Cobrado<BR>Pendiente<BR>Cambio
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Rojo obscuro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Totalizadores2=Suma(VentaCobroD:ImporteNeto)<BR>Si(Info.Importe-Suma(VentaCobroD:ImporteNeto) > 0, Info.Importe-Suma(VentaCobroD:ImporteNeto))<BR>Si(Suma(VentaCobroD:ImporteNeto)-Info.Importe > 0, Suma(VentaCobroD:ImporteNeto)-Info.Importe)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
TotAlCambiar=S

[(Carpeta Totalizadores).Total Cobrado]
Carpeta=(Carpeta Totalizadores)
Clave=Total Cobrado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Pendiente]
Carpeta=(Carpeta Totalizadores)
Clave=Pendiente
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Rojo obscuro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Cambio]
Carpeta=(Carpeta Totalizadores)
Clave=Cambio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
Pegado=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=<T>&Afectar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=(no Info.Cerrado) y (no Usuario.BloquearCobroInmediato)
AntesExpresiones=Si(Usuario.AbrirCajon,Cajon.Abrir)<BR>Afectar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>Venta<T>)

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
Menu=&Archivo
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
EnMenu=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
ActivoCondicion=no Info.Cerrado
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerra&r
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.ImporteNeto]
Carpeta=Lista
Clave=ImporteNeto
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Monedas]
Nombre=Monedas
Boton=64
NombreEnBoton=S
NombreDesplegar=&Otras Monedas
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
EspacioPrevio=S
Menu=&Ver
GuardarAntes=S
ActivoCondicion=no Info.VerDetalles
AntesExpresiones=Asigna(Info.VerDetalles, Verdadero)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Afectar
Afectar=Cancelar
Cancelar=Cerrar
Cerrar=Monedas
Monedas=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VentaCobroD.Importe
VentaCobroD.Importe=VentaCobroD.FormaCobro
VentaCobroD.FormaCobro=VentaCobroD.Referencia
VentaCobroD.Referencia=VentaCobroD.Moneda
VentaCobroD.Moneda=VentaCobroD.TipoCambio
VentaCobroD.TipoCambio=ImporteNeto
ImporteNeto=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Pendiente
Pendiente=Cambio
Cambio=Total Cobrado
Total Cobrado=(Fin)
