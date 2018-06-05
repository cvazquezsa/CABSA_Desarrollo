[Forma]
Clave=MovTipoContAuto
Nombre=<T>Póliza Automática - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=570
PosicionInicialArriba=376
PosicionInicialAlturaCliente=413
PosicionInicialAncho=779
PosicionColumna1=40
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(e(<T>Empresa<T>)+<T>: <T>+Info.Empresa, Info.Clave)
PosicionSeccion1=65
PosicionSec1=214

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=MovTipoContAuto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaOtroNombre=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática

FiltroGeneral=MovTipoContAuto.Empresa=<T>{Info.Empresa}<T> AND<BR>MovTipoContAuto.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoContAuto.Clave=<T>{Info.Clave}<T>
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=MovTipoContAuto
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

[Ficha.MovTipoContAuto.Nombre]
Carpeta=Ficha
Clave=MovTipoContAuto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Cta.Descripcion]
Carpeta=Ficha
Clave=Cta.Descripcion
Editar=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Lista.Columnas]
Nombre=258
Importe=65
Debe=170
Haber=152
0=305
1=169
eDebe=222
eHaber=227

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Forma(<T>MovTipoContAutoOrdenar<T>)

[Ficha.MovTipoContAuto.Debe]
Carpeta=Ficha
Clave=MovTipoContAuto.Debe
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.Haber]
Carpeta=Ficha
Clave=MovTipoContAuto.Haber
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.Cuenta]
Carpeta=Ficha
Clave=MovTipoContAuto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.CuentaOmision]
Carpeta=Ficha
Clave=MovTipoContAuto.CuentaOmision
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.OmitirConcepto]
Carpeta=Ficha
Clave=MovTipoContAuto.OmitirConcepto
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.MovTipoContAuto.Condicion]
Carpeta=Ficha
Clave=MovTipoContAuto.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.OmitirCentroCostos]
Carpeta=Ficha
Clave=MovTipoContAuto.OmitirCentroCostos
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=&Tabla
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovTipoContAutoTabla
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=MovTipoContAuto:MovTipoContAuto.Cuenta=<T>Tabla %<T>
EjecucionCondicion=ConDatos(MovTipoContAuto:MovTipoContAuto.Nombre)
AntesExpresiones=Asigna(Info.Nombre, MovTipoContAuto:MovTipoContAuto.Nombre)

[Ficha.MovTipoContAuto.IncluirArticulos]
Carpeta=Ficha
Clave=MovTipoContAuto.IncluirArticulos
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.CentroCostos]
Carpeta=Ficha
Clave=MovTipoContAuto.CentroCostos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.IncluirDepartamento]
Carpeta=Ficha
Clave=MovTipoContAuto.IncluirDepartamento
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovTipoContAuto.Sucursal]
Carpeta=Ficha
Clave=MovTipoContAuto.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LoteFijo]
Nombre=LoteFijo
Boton=47
NombreEnBoton=S
NombreDesplegar=&Lote Fijo Especifico
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoContAutoLoteFijo
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=MovTipoContAuto:MovTipoContAuto.Cuenta=<T>Lote Fijo Especifico<T>
EjecucionCondicion=ConDatos(MovTipoContAuto:MovTipoContAuto.Nombre)
AntesExpresiones=Asigna(Info.Nombre, MovTipoContAuto:MovTipoContAuto.Nombre)

[Ficha.MovTipoContAuto.Concepto]
Carpeta=Ficha
Clave=MovTipoContAuto.Concepto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


LineaNueva=N
[Ficha.MovTipoContAuto.ObligacionFiscal]
Carpeta=Ficha
Clave=MovTipoContAuto.ObligacionFiscal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoContAuto.Nombre]
Carpeta=Lista
Clave=MovTipoContAuto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.eDebe]
Carpeta=Lista
Clave=eDebe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.eHaber]
Carpeta=Lista
Clave=eHaber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro





[Ficha.MovTipoContAuto.ContactoEspecifico]
Carpeta=Ficha
Clave=MovTipoContAuto.ContactoEspecifico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Ficha.ListaEnCaptura]
(Inicio)=MovTipoContAuto.Nombre
MovTipoContAuto.Nombre=MovTipoContAuto.Condicion
MovTipoContAuto.Condicion=MovTipoContAuto.Debe
MovTipoContAuto.Debe=MovTipoContAuto.Haber
MovTipoContAuto.Haber=MovTipoContAuto.Sucursal
MovTipoContAuto.Sucursal=MovTipoContAuto.Cuenta
MovTipoContAuto.Cuenta=MovTipoContAuto.CuentaOmision
MovTipoContAuto.CuentaOmision=Cta.Descripcion
Cta.Descripcion=MovTipoContAuto.Concepto
MovTipoContAuto.Concepto=MovTipoContAuto.ObligacionFiscal
MovTipoContAuto.ObligacionFiscal=MovTipoContAuto.ContactoEspecifico
MovTipoContAuto.ContactoEspecifico=MovTipoContAuto.CentroCostos
MovTipoContAuto.CentroCostos=MovTipoContAuto.OmitirConcepto
MovTipoContAuto.OmitirConcepto=MovTipoContAuto.OmitirCentroCostos
MovTipoContAuto.OmitirCentroCostos=MovTipoContAuto.IncluirArticulos
MovTipoContAuto.IncluirArticulos=MovTipoContAuto.IncluirDepartamento
MovTipoContAuto.IncluirDepartamento=(Fin)







[Lista.ListaEnCaptura]
(Inicio)=MovTipoContAuto.Nombre
MovTipoContAuto.Nombre=eDebe
eDebe=eHaber
eHaber=(Fin)

[Lista.ListaOrden]
(Inicio)=MovTipoContAuto.Orden	(Acendente)
MovTipoContAuto.Orden	(Acendente)=MovTipoContAuto.Nombre	(Acendente)
MovTipoContAuto.Nombre	(Acendente)=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Tabla
Tabla=LoteFijo
LoteFijo=Orden
Orden=(Fin)
