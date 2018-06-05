[Forma]
Clave=CxpDocAuto
Nombre=<T>Documentaci�n Autom�tica - Cuentas por Pagar<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=177
PosicionInicialArriba=195
PosicionInicialAltura=346
PosicionInicialAncho=669
IniciarAgregando=S
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsMovimiento=S
TituloAuto=S
MovModulo=CXP
MovEspecificos=Todos
PosicionInicialAlturaCliente=344

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxpDocAuto
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=95
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioNombresAuto=S

[Ficha.DocAuto.Cuenta]
Carpeta=Ficha
Clave=DocAuto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.DocAuto.Mov]
Carpeta=Ficha
Clave=DocAuto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.DocAuto.MovID]
Carpeta=Ficha
Clave=DocAuto.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N
Tamano=10
IgnoraFlujo=N

[Ficha.DocAuto.ImporteDocumentar]
Carpeta=Ficha
Clave=DocAuto.ImporteDocumentar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=23

[Ficha.DocAuto.NumeroDocumentos]
Carpeta=Ficha
Clave=DocAuto.NumeroDocumentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=4
EspacioPrevio=N

[Ficha.DocAuto.PrimerVencimiento]
Carpeta=Ficha
Clave=DocAuto.PrimerVencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=23
EspacioPrevio=N

[Ficha.DocAuto.Periodo]
Carpeta=Ficha
Clave=DocAuto.Periodo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=11
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.DocAuto.Observaciones]
Carpeta=Ficha
Clave=DocAuto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Aceptar
Antes=S
DespuesGuardar=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(CxpDocAuto:DocAuto.Periodo) y (CxpDocAuto:DocAuto.Periodo<><T><dias><T>)
EjecucionMensaje=<T>Periodo Incorrecto<T>
AntesExpresiones=Si<BR>  Precaucion(<T>� Esta Seguro ?<T>,BotonSi,BotonNo)=BotonSi<BR>Entonces<BR>  ProcesarSQL(<T>spDocAuto :nID, :tNCargo, :tDoc, :tUsuario<T>,CxpDocAuto:DocAuto.ID,ConfigMov.CxpCargoProveedor, CxpDocAuto:DocAuto.Documento, Usuario)<BR>Sino<BR>  AbortarOperacion<BR>Fin

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
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S
EspacioPrevio=S

[Ficha.DocAuto.Moneda]
Carpeta=Ficha
Clave=DocAuto.Moneda
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Total]
Carpeta=Ficha
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.DocAuto.Intereses]
Carpeta=Ficha
Clave=DocAuto.Intereses
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.DocAuto.InteresesImpuestos]
Carpeta=Ficha
Clave=DocAuto.InteresesImpuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.DocAuto.InteresesConcepto]
Carpeta=Ficha
Clave=DocAuto.InteresesConcepto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.DocAuto.Concepto]
Carpeta=Ficha
Clave=DocAuto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.CxpPendiente.Referencia]
Carpeta=Ficha
Clave=CxpPendiente.Referencia
3D=S
Tamano=16
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CxpPendiente.FechaEmision]
Carpeta=Ficha
Clave=CxpPendiente.FechaEmision
3D=S
Pegado=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CxpPendiente.Vencimiento]
Carpeta=Ficha
Clave=CxpPendiente.Vencimiento
3D=S
Pegado=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro

[Ficha.DocAuto.ImpPrimerDoc]
Carpeta=Ficha
Clave=DocAuto.ImpPrimerDoc
Editar=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.DocAuto.Documento]
Carpeta=Ficha
Clave=DocAuto.Documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=DocAuto.Cuenta
DocAuto.Cuenta=Prov.Nombre
Prov.Nombre=DocAuto.Moneda
DocAuto.Moneda=DocAuto.Mov
DocAuto.Mov=DocAuto.MovID
DocAuto.MovID=CxpPendiente.Referencia
CxpPendiente.Referencia=CxpPendiente.FechaEmision
CxpPendiente.FechaEmision=CxpPendiente.Vencimiento
CxpPendiente.Vencimiento=DocAuto.ImporteDocumentar
DocAuto.ImporteDocumentar=DocAuto.ImpPrimerDoc
DocAuto.ImpPrimerDoc=DocAuto.Intereses
DocAuto.Intereses=DocAuto.InteresesConcepto
DocAuto.InteresesConcepto=DocAuto.InteresesImpuestos
DocAuto.InteresesImpuestos=Total
Total=DocAuto.Documento
DocAuto.Documento=DocAuto.NumeroDocumentos
DocAuto.NumeroDocumentos=DocAuto.Periodo
DocAuto.Periodo=DocAuto.PrimerVencimiento
DocAuto.PrimerVencimiento=DocAuto.Concepto
DocAuto.Concepto=DocAuto.Observaciones
DocAuto.Observaciones=(Fin)
